extends Node2D

signal on_health_bar_died
signal on_updated

func _on_Actor_update_health_bar(damage):
	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,$TextureProgress.value-damage,0.2,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Tween.start()
	emit_signal("on_updated")
	if $TextureProgress.value<=0:
		emit_signal("on_health_bar_died")

