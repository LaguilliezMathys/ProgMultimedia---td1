extends Node

@export var speed = 400


func _physics_process(delta):
	var raquette : CharacterBody2D = get_parent()
	
	raquette.velocity.y = 0
	raquette.velocity.x = 0
	
	 
	
	
	if Input.is_action_pressed("p1_left"):
		raquette.velocity.x =  -speed
	elif Input.is_action_pressed("p1_right"):
		raquette.velocity.x = speed
	
	raquette.move_and_slide()
