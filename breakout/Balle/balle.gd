extends RigidBody2D

@export var speed: float = 450.0

# Raquette
@export var paddle_width: float = 160.0   # ⚠️ mets ici la largeur EXACTE de ta raquette
@export var max_angle_deg: float = 60.0
@export var min_upward_y: float = 0.45     # force la balle à monter

# Murs / autres collisions
@export var random_angle_deg: float = 3.0

var _just_bounced: bool = false


func _ready() -> void:
	add_to_group("ball")

	gravity_scale = 0.0
	linear_damp = 0.0
	angular_damp = 0.0
	can_sleep = false
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY

	# Direction initiale vers le bas
	linear_velocity = Vector2(0, speed)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var contact_count := state.get_contact_count()

	if contact_count == 0:
		_just_bounced = false
		_keep_speed()
		return

	# Évite plusieurs rebonds la même frame
	if _just_bounced:
		_keep_speed()
		return
	_just_bounced = true

	var collider_obj := state.get_contact_collider_object(0)
	var normal: Vector2 = state.get_contact_local_normal(0)

	# =============================
	# 🟢 COLLISION AVEC LA RAQUETTE
	# =============================
	if collider_obj != null and collider_obj.is_in_group("paddle"):
		var paddle := collider_obj as Node2D
		if paddle == null:
			return

		# Position d'impact sur la raquette (-1 à +1)
		var offset: float = (global_position.x - paddle.global_position.x) / (paddle_width * 0.5)
		offset = clamp(offset, -1.0, 1.0)

		# Angle dépendant de l'impact
		var angle := deg_to_rad(offset * max_angle_deg)

		# Direction vers le HAUT
		var dir := Vector2(sin(angle), -cos(angle)).normalized()

		# Anti "gauche-droite"
		if abs(dir.y) < min_upward_y:
			dir.y = -min_upward_y
			dir = dir.normalized()

		linear_velocity = dir * speed
		return

	# =============================
	# 🔵 COLLISION AVEC MURS / AUTRES
	# =============================
	var dir2 := linear_velocity.bounce(normal).normalized()
	dir2 = dir2.rotated(deg_to_rad(randf_range(-random_angle_deg, random_angle_deg)))

	# Anti trajectoire plate
	if abs(dir2.y) < 0.2:
		dir2.y = sign(dir2.y if dir2.y != 0.0 else -1.0) * 0.2
		dir2 = dir2.normalized()

	linear_velocity = dir2 * speed


func _keep_speed() -> void:
	if linear_velocity.length() > 0.1:
		linear_velocity = linear_velocity.normalized() * speed
