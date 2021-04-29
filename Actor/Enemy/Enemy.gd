extends "res://Actor/Actor.gd"

var target_position=Vector2()
var steering_vector=Vector2(1,1)
var mode="Wander"
func state_logic(delta):
	move(delta)

func transition(delta):
	return null

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass

func move(delta):
	
	target_position=get_global_mouse_position()
	var desired_velocity=target_position-global_position
	var distance=desired_velocity.length()
	if mode in ["Wander"]:
		if distance<50:
			desired_velocity=desired_velocity.normalized()*300*(distance/50)
		else:
			desired_velocity=desired_velocity.normalized()*300
		steering_vector=desired_velocity-velocity/5.0
	else:
		var flee_velocity=-desired_velocity
		steering_vector=flee_velocity-velocity/5.0
	var i =(300/(velocity+steering_vector).length())
	i=min(i,1.0)
	velocity=(velocity+steering_vector)*i
	velocity=move_and_slide(velocity)
	if Input.is_action_pressed("ui_accept"):
		mode="wande"
	if Input.is_action_just_pressed("ui_left"):
		mode="Wander"
