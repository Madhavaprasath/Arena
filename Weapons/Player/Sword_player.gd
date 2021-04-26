extends weapon

onready var tween=get_node("Tween")

var can_attack=true

func main(delta):
	match current_state:
		"Working":
			var distance=$Pivot.global_position.distance_to(get_global_mouse_position())
			if distance>20:
				$Pivot.look_at(get_global_mouse_position())
		"Attack":
			$Pivot/AnimationPlayer.play("Attack")
func _unhandled_input(event):
	if event.is_action_pressed("Click") && enabled:
		current_state="Attack"

func attack():
	if current_state in ["Attack"] && can_attack:
		can_attack=false
		tween.interpolate_property($Pivot,"rotation",$Pivot.rotation,$Pivot.rotation+2*PI,0.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		tween.start()
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["Attack"]:
		current_state="Working"
		can_attack=true
