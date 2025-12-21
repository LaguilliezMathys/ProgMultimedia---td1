extends Node

@export var speed := 400.0
@export var half_width := 60.0 # ajuste selon la taille de ta raquette

func _physics_process(delta: float) -> void:
	var raquette := get_parent() as Node2D
	if raquette == null:
		return

	var dir := 0.0
	if Input.is_action_pressed("p1_left"):
		dir = -1.0
	elif Input.is_action_pressed("p1_right"):
		dir = 1.0

	# Déplacement horizontal (fonctionne pour StaticBody2D et CharacterBody2D)
	raquette.position.x += dir * speed * delta

	# Clamp écran
	var viewport_w := raquette.get_viewport_rect().size.x
	raquette.position.x = clamp(raquette.position.x, half_width, viewport_w - half_width)
