extends StaticBody2D

export(bool) var running = false

func _ready():
	$area_2d.connect("body_entered", self, "body_entered")
	$area_2d.connect("body_exited", self, "body_exited")
	
	set_running(running)

func set_running(value):
	running = value
	if running:
		$animated_sprite.play()
		for body in $area_2d.get_overlapping_bodies():
			body_entered(body)
	else:
		$animated_sprite.stop()
		for body in $area_2d.get_overlapping_bodies():
			body_exited(body)

func body_entered(body):
	if running and body.has_method("up_moving_belts"):
		body.up_moving_belts()

func body_exited(body):
	if body.has_method("down_moving_belts"):
		body.down_moving_belts()


