extends "res://Actor/Weapons.gd"


func main(delta):
	#declare some thing which is characterstic for each weapons
	pass

func _unhandled_input(event):
	var modes={'Bow':event.is_action_pressed("E"),
			'Sword':event.is_action_pressed("R"),
			'Staff':event.is_action_pressed("T")}
	for i in modes.keys():
		if modes[i]:
			for j in get_children():
				if i==j.name:
					j.enabled=true
				else:
					j.enabled=false

func give_damage():
	pass
