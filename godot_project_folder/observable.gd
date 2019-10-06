extends Node2D

signal looked_at
signal looked_away_from

export(bool) var enabled = true
export(int) var trigger_distance = 50

var looking_at = false

func _process(delta):
	var distance_to_mouse = (global_position - get_global_mouse_position()).length()
	
	if enabled and distance_to_mouse < trigger_distance and not looking_at:
		emit_signal("looked_at")
		looking_at = true
	elif enabled and distance_to_mouse > trigger_distance and looking_at:
		looking_at = false
		emit_signal("looked_away_from")
