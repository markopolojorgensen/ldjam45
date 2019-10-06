extends Node2D

var opened = false

func open():
	if not opened:
		opened = true
		$animated_sprite.play("open")
		$animation_player.play("open")

func close():
	if opened:
		opened = false
		$animated_sprite.play("close")
		$animation_player.play("close")

