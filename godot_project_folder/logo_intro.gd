extends MarginContainer

func _ready():
	# startup delay (wait for window to open)
	yield(get_tree().create_timer(0.4), "timeout")
	
	$center_container/control/logo_sprite.play()
	
	# wait for logo to play
	yield(get_tree().create_timer(1.6), "timeout")
	
	# start actual game
	get_tree().quit()
	
