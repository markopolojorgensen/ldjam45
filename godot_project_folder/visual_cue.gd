extends Node2D

signal looked_at

const trigger_distance = 100
const resolution = Vector2(1024, 576)

var enabled = true

func _ready():
	randomize()
	var destination = resolution - Vector2(80, 80)
	destination.x *= randf()
	destination.y *= randf()
	destination += Vector2(40, 40)
	global_position = destination
	
	$animated_sprite.frame = randi() % $animated_sprite.frames.get_frame_count("default")
	$animated_sprite.play()

func _process(delta):
	var distance_to_mouse = (global_position - get_global_mouse_position()).length()
	
	if enabled and distance_to_mouse < trigger_distance:
		emit_signal("looked_at")
		
		$audio_stream_player_2d.play()
		
		# fade out
		$tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$tween.start()
		
		set_process(false)
		enabled = false
		
		$death_timer.start()
		yield($death_timer, "timeout")
		
		queue_free()





