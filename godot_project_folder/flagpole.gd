extends Node2D

var raised = false

func raise():
	if not raised:
		raised = true
		$flag.play()
		$animation_player.play("raise")

