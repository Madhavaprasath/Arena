extends Node2D

signal on_health_bar_died

func _on_Actor_update_health_bar(damage):
	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,$TextureProgress.value-damage,0.2,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Tween.start()
	if $TextureProgress.value<=0:
		emit_signal("on_health_bar_died")

