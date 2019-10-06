extends Node2D

func _process(delta):
	var direction = (get_global_mouse_position() - global_position + Vector2(0, 40))
	var angle = rad2deg(direction.angle())
	angle += 90
	if angle > 180:
		angle = - (180 - (angle - 180))
	
	if angle < 0:
		$head_sprite.flip_h = true
	else:
		$head_sprite.flip_h = false
	
	angle = abs(angle)
	
	if angle < 20:
		$head_sprite.play("up")
	elif angle < 50:
		$head_sprite.play("up_angle")
	elif angle < 120:
		$head_sprite.play("horizontal")
	elif angle < 180:
		$head_sprite.play("down_angle")
	else:
		print("mystery head direction: %s" % str(angle))



