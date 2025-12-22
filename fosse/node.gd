extends Node


@onready var zone_fosse = $".."

func _ready():
	zone_fosse.body_entered.connect(_on_balle_entree)

func _on_balle_entree(body):

	if body.is_in_group("balle"):
		print("Perdu !")

		get_tree().change_scene_to_file("res://cassebrique/game_over.tscn")
