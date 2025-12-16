extends Node

@export var speed = 400


func get_input():
	var raquette : CharacterBody2D = get_node("..")
	var input_direction = Input.get_vector("left", "right", "up", "down")
	raquette.velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
