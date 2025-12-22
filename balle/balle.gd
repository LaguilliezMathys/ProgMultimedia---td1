extends Node

@onready var la_balle = $".." 
@onready var son_brique = $SonBrique
func _ready():
	var impulsion = Vector2(-100, -200)

	la_balle.apply_central_impulse(impulsion)
	la_balle.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("brique"):
		var briques_restantes = get_tree().get_nodes_in_group("brique").size()
		son_brique.play()

		if briques_restantes == 1:
			print("Victoire !")
			call_deferred("changer_scene")
			
		body.queue_free()
	if body.is_in_group("mur"):
		$SonMur.play()
	if body.is_in_group("raquette"):
		$SonRaquette.play()

func changer_scene():
	get_tree().change_scene_to_file("res://cassebrique/victoire.tscn")
