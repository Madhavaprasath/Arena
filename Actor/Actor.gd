extends KinematicBody2D

signal update_health_bar(damage)


export (int) var speed=200
export (int) var health=100
export (Vector2) var damage_vector=Vector2(20,40)
export (int) var acc=200
export (int) var friction=500


var states={}
var current_state
var previous_state
var velocity=Vector2() 
var is_being_attacked=false

onready var animation_player=get_node("Body/AnimationPlayer")
func _ready():
	randomize()

func _physics_process(delta):
	state_logic(delta)
	var transition_state=transition(delta)
	if transition_state!=null:
		current_state=transition_state
		previous_state=current_state
		enter_state(previous_state,current_state)
		exit_state(previous_state,current_state)

func state_logic(delta):
	pass

func transition(delta):
	return null

func enter_state(old_state,new_state):
	pass

func exit_state(old_state,new_state):
	pass

func take_damage(damage):
	is_being_attacked=true
	var Damage=rand_range(damage_vector.x,damage_vector.y)
	health-=Damage
	emit_signal("update_health_bar",Damage)


func die():
	pass


func _on_Healthbar_on_updated():
	is_being_attacked=false
