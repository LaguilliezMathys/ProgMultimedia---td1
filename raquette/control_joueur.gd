extends Node

@export var vitesse := 400.0

func _physics_process(delta):
	var raquette = get_parent();
	if Input.is_action_pressed("p1_left"):
		raquette.position.x -= vitesse * delta
		
	if Input.is_action_pressed("p1_right"):
		raquette.position.x += vitesse * delta

	var ecran_largeur = get_viewport().get_visible_rect().size.x
	raquette.position.x = clamp(raquette.position.x, 35, ecran_largeur - 35)
