extends Node2D

var arrow_active = false
var flag_raised = false

func _on_arrow_looked_at():
	if arrow_active:
		arrow_active = false
		$ding.play()
		$gate.open()
		stop_arrow($arrow/animated_sprite)
		$music_manager.add_layer()

func _on_sight_sense_sight_acquired():
	$player.sprout_camera()
	arrow_active = true
	$music_manager.add_layer()

func _on_flag_arrow_looked_at():
	if not flag_raised:
		stop_arrow($arrow_2/animated_sprite)
		flag_raised = true
		$flagpole.raise()
		$music_manager.add_layer()
		
		yield(get_tree().create_timer(2.0), "timeout")
		
		get_parent().level_beaten(1)
		get_parent().change_level(0)
		
		# todo: add more levels
		# $game_victory_screen.fade_in()

func stop_arrow(arrow_sprite):
	arrow_sprite.stop()
	arrow_sprite.frame = 28

