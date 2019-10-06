extends Node2D

var sight_acquired = false
var level_beaten = false
var health_hud_revealed = false

var triggers_tripped = 0

func _on_sight_sense_sight_acquired():
	if not sight_acquired:
		sight_acquired = true
		$music_manager.add_layer()
		$player.sprout_camera()
		$arrow_flagpole.enabled = true

func _on_arrow_flagpole_looked_at():
	if not level_beaten:
		level_beaten = true
		$arrow_flagpole/ding.play()
		$flagpole.raise()
		$music_manager.add_layer()
		
		yield(get_tree().create_timer(2.0), "timeout")
		
		get_parent().level_beaten(5)
		
		$game_victory_screen.fade_in()

func return_to_main_menu():
	get_parent().change_level(0)

func _on_player_took_damage(amount):
	$health_hud.take_damage(amount)
	if not health_hud_revealed:
		health_hud_revealed = true
		$health_hud.show()

func _on_health_hud_player_death():
	$player.die()
	$music_manager.stop()
	
	yield(get_tree().create_timer(2.0), "timeout")
	
	get_parent().change_level(0)

func add_trigger():
	triggers_tripped += 1
	if triggers_tripped >= 2:
		$flag_gate.open()

func _on_trigger_2_body_entered(body):
	$ding.play()
	add_trigger()
	$trigger_2.queue_free()
	$text/sense_of_humor/funny.show()
	$music_manager.add_layer()

func _on_sunrise_looked_at():
	$ding.play()
	add_trigger()
	$text/sense_of_wonder/pretty.show()
	$music_manager.add_layer()
