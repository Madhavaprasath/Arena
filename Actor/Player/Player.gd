extends "res://Actor/Actor.gd"


var knock_back_vector:Vector2=Vector2()
var input_vector:Vector2=Vector2()

var action:Dictionary={'Left':Input.is_action_pressed("ui_left"),
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

func _ready():
	current_state=states[1]

#parent functions
func state_logic(delta):
	apply_movement(delta)
	if current_state in ["Idle"]:
		velocity=velocity.move_toward(Vector2.ZERO,friction*delta)
func transition(delta):
	match current_state:
		"Idle":
			if input_vector!=Vector2():
				return states[2]
		"Run":
			if input_vector==Vector2():
				return states[1]
	return null

func enter_state(old_state,new_state):
	animation_player.play(new_state)

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
		velocity+=input_vector*acc*delta
		check_velocity()
	move_and_slide(velocity)

func check_velocity()->void:
	velocity.x=clamp(velocity.x,-speed,speed)
	velocity.y=clamp(velocity.y,-speed,speed)
