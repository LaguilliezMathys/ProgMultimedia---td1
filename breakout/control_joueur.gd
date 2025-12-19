extends Node

@export var speed = 400


func _physics_process(delta):
	var raquette : CharacterBody2D = get_parent()
	if Input.action_press("p1_left"):
		raquette.velocity.x =  speed
	elif Input.action_press("p1_right"):
			raquette.velocity.y = -speed
	
	raquette.move_and_slide()
