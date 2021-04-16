extends "res://Actor/Actor.gd"


var knock_back_vector=Vector2()
var input_vector=Vector2()
var action={'Left':Input.is_action_pressed("ui_left"),
			'Right':Input.is_action_pressed("ui_right"),
			'Up':Input.is_action_pressed("ui_up"),
			'Down':Input.is_action_pressed("ui_down"),
			'E':Input.is_action_pressed("E"),
			'R':Input.is_action_pressed("R"),
			'T':Input.is_action_pressed("T")}

func _init():
	states={1:"Idle",
			2:"Run",
			3:"Attack",
			4:"Knock_back",
			5:"Pickup",
			6:"Dead"}



#parent functions
func state_logic(delta):
	apply_movement(delta)
	position.x=clamp(position.x,0,1000)
	position.y=clamp(position.y,0,600)
func transition(delta):
	return null

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass

#user defined function for player

func apply_movement(delta:float)->void:
	var action={'Left':Input.is_action_pressed("ui_left"),
			'Right':Input.is_action_pressed("ui_right"),
			'Up':Input.is_action_pressed("ui_up"),
			'Down':Input.is_action_pressed("ui_down")}
	input_vector.x=int(action['Right'])-int(action['Left'])
	input_vector.y=int(action['Down'])-int(action['Up'])
	input_vector=input_vector.normalized()
	knock_back_vector=input_vector
	if input_vector!=Vector2.ZERO:
		velocity+=input_vector*acc
		check_velocity(velocity)
	else:
		velocity=lerp(velocity,Vector2(),1)
	move_and_slide(velocity)


func check_velocity(velocity:Vector2)->void:
	if abs(velocity.x)>speed:
		if velocity.x<0:
			velocity.x=-speed
		else:
			velocity.x=speed
	if abs(velocity.y)>speed/2:
		if velocity.y<0:
			velocity.y=-speed/2
		else:
			velocity.y=speed/2

func deaccerlarate(velocity):
	velocity=Vector2()
