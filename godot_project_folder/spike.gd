extends Node2D

export(int) var interval = 0

func _ready():
	if interval != 0:
		$stab_interval.wait_time = interval
		$stab_interval.start()

func stab():
	$animation_player.play("stab")

func _on_spike_body_entered(body):
	if body.has_method("hit_by_spike"):
		body.hit_by_spike(self)

func ding():
	$ding.play()

func _on_stab_interval_timeout():
	stab()





