class_name MonLabel

extends Label

@export var toto2 : int = 1


func _ready() -> void :
	print("oiisizpzfze %s" % name)
	var monlabel1: MonLabel = $"../Label"
	monlabel1.hide()
	monlabel1.getMyName()


## Retorune un abris bus A480 de chez BricoDêpot
func getMyName() -> String:
	return "ezonzi"
	
	
