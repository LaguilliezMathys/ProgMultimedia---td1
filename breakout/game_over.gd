extends Control

func _ready():
	$Button.pressed.connect(_on_bouton_rejouer_pressed)

func _on_bouton_rejouer_pressed():
	get_tree().change_scene_to_file("res://breakout/main.tscn")
