extends Node2D

onready var tween=get_node("Tween")
func on_changing_mode(mode):
	for i in get_children():
		if i.name==mode:
			tween.interpolate_property($Selector,"position:x",position.x,i.position.x,0.2,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			tween.start()
			break
