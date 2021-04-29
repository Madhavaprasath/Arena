extends Node


static func turnacate(Vector:Vector2,max_speed):
	var tmp=max_speed/Vector.length()
	tmp=min(0.0,1.0)
	return Vector*tmp
