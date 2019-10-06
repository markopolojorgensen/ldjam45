extends MarginContainer

func _ready():
	# startup delay (wait for window to open)
	yield(get_tree().create_timer(0.4), "timeout")
	
	$center_container/control/logo_sprite.play()
	
	$audio_stream_player.play()
	
	# wait for logo to play
	yield(get_tree().create_timer(1.6), "timeout")
	
	$tween.interpolate_property(self, "modulate", Color.white, Color(1,1,1,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$tween.start()
	
	yield($tween, "tween_completed")
	
	queue_free()

