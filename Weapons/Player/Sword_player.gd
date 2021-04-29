extends weapon

onready var tween=get_node("Tween")
onready var player=get_parent().get_parent()

var can_attack=true




func main(delta):
	match current_state:
		"Working":
			var distance=$Pivot.global_position.distance_to(get_global_mouse_position())
			var angle=global_position.angle_to_point(get_global_mouse_position())
			rotation=(angle+PI)
		"Attack":
			$Pivot/AnimationPlayer.play("Attack")
func _input(event):
	if event.is_action_pressed("Click") && enabled:
		current_state="Attack"

func attack():
	if current_state in ["Attack"] && can_attack:
		tween.interpolate_property(self,"rotation",rotation,rotation+2*PI,0.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		tween.start()
		can_attack=false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["Attack"]:
		can_attack=true
		current_state="Working"


