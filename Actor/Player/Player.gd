extends "res://Actor/Actor.gd"

signal change_mode(mode)
var mode="Sword"
var direction_vector=Vector2()
var velocity=Vector2()

onready var Items=get_node("Body/Items")
onready var animation_player=get_node("Body/AnimationPlayer")
onready var body=get_node("Body")
onready var PlayerUI=get_node("UI")

func _init():
	states={1:"Idle",
			2:"Run",
			3:"Attack"}

func _ready():
	current_state=states[1]

func state_logic(delta):
	apply_movement(delta)
	change_mode()
	flip_character()

func transition(delta):
	match current_state:
		"Idle":
			if direction_vector!=Vector2(0,0):
				return states[2]
		"Run":
			if direction_vector==Vector2(0,0):
				return states[1]
	return null

func enter_state(old_state,new_state):
	animation_player.play(new_state)

func exit_state(old_state,new_state):
	pass

func apply_movement(delta):
	var directions={'Left':Input.is_action_pressed("ui_left"),
					'Right':Input.is_action_pressed("ui_right"),
					'Up':Input.is_action_pressed("ui_up"),
					'Down':Input.is_action_pressed("ui_down")}
	direction_vector.x=int(directions['Right'])-int(directions['Left'])
	direction_vector.y=int(directions['Down'])-int(directions['Up'])
	direction_vector=direction_vector.normalized()
	
	if direction_vector!=Vector2(0,0):
		if abs(velocity.x)>speed:
			if velocity.x>0:
				velocity=Vector2(speed,velocity.y)
			else:
				velocity=Vector2(-speed,velocity.y)
		if abs(velocity.y)>speed:
			if velocity.y>0:
				velocity=Vector2(velocity.x,speed)
			else:
				velocity=Vector2(velocity.x,-speed)
	else:
		velocity=lerp(velocity,Vector2(0,0),0.1)
	velocity+=acc*direction_vector
	velocity=move_and_slide(velocity)

func flip_character():
	var direction=int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	if direction!=0:
		body.scale.x=direction*2.5



func change_mode():
	var modes={"Sword":Input.is_action_pressed("E"),
				"Bow":Input.is_action_pressed("R"),
				"Staff":Input.is_action_pressed("T")}
	for i in modes.keys():
		if modes[i]:
			mode=i
			print(mode)
	for j in Items.get_children():
		if j.name==mode:
			j.visible=true
		else:
			j.visible=false
	for k in PlayerUI.get_children():
		if k.name==mode:
			PlayerUI.get_node("Tween").interpolate_property(PlayerUI.get_node("Selector"),"position:x",PlayerUI.get_node("Selector").position.x,k.position.x,0.2,Tween.TRANS_SINE,Tween.EASE_OUT_IN)
			PlayerUI.get_node("Tween").start()
