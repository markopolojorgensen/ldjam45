extends Node2D

var sight_acquired = false
var arrow_spike_looked_at = false
var level_beaten = false
var health_hud_revealed = false

func _on_sight_sense_sight_acquired():
	if not sight_acquired:
		sight_acquired = true
		$arrow_spike.enabled = true
		$player.sprout_camera()
		$music_manager.add_layer()

func _on_arrow_spike_looked_at():
	if not arrow_spike_looked_at:
		arrow_spike_looked_at = true
		$arrow_spike/ding.play()
		$arrow_flagpole.enabled = true
		$spike_trap.stab()
		$music_manager.add_layer()

func _on_arrow_flagpole_looked_at():
	if not level_beaten:
		level_beaten = true
		$arrow_flagpole/ding.play()
		$flagpole.raise()
		$music_manager.add_layer()
		
		yield(get_tree().create_timer(2.0), "timeout")
		
		get_parent().level_beaten(2)
		get_parent().change_level(0)

func _on_player_took_damage(amount):
	$health_hud.take_damage(amount)
	if not health_hud_revealed:
		health_hud_revealed = true
		$health_hud.show()

