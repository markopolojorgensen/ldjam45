extends Node2D

func _ready():
	$banana.show()
	$banana_explosion.hide()

func _on_area_2d_body_entered(body):
	$banana.hide()
	$banana_explosion.show()
	$banana_explosion.play()
