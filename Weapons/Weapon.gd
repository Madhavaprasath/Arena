extends Node2D
class_name weapon

var current_state="Working"
var enabled=true

func _physics_process(delta):
	main(delta)

#user defined function
func main(delta):
	pass

func attack():
	pass

func match_state(state):
	pass
