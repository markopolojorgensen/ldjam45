extends Node2D

func _on_area_2d_body_entered(body):
	if body.has_method("find_treads"):
		body.find_treads()
		body.apply_central_impulse(Vector2(0, -1200))
		queue_free()
