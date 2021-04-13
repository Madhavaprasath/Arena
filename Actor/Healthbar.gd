extends Node2D



func _on_Actor_update_health_bar(damage):
	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,$TextureProgress.value-damage,0.2,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Tween.start()
