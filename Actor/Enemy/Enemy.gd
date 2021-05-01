extends "res://Actor/Actor.gd"

var target_position=Vector2()
var steering_vector=Vector2(1,1)
var mode="Wander"
func state_logic(delta):
	#move(delta)
	pass

func transition(delta):
	return null

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass

func move(delta):
	var steering_array=determine_steering_factors(get_global_mouse_position())
	var desired_velocity=steering_array[0]
	var distance=steering_array[1]
	#chase
	if mode in ["Wander"]:
		if distance<50:
			desired_velocity=desired_velocity.normalized()*300*(distance/50)
		else:
			desired_velocity=desired_velocity.normalized()*300
		steering_vector=desired_velocity-velocity/5.0
	#flee
	else:
		var flee_velocity=-desired_velocity
		steering_vector=flee_velocity-velocity/5.0
	velocity=turnacate(velocity+steering_vector,300)
	velocity=move_and_slide(velocity)

func turnacate(vector,max_speed):
	var i =(max_speed/(vector).length()) if vector!=Vector2() else 0.0
	i=min(i,1.0)
	return vector*i

func determine_steering_factors(target_vector):
	target_position=target_vector
	var desired_vector=target_position-global_position
	var distance=desired_vector.length()
	return [desired_vector,distance]
