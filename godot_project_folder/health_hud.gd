extends CanvasLayer

signal player_death

export(int) var player_max_health = 4
var player_current_health

func _ready():
	player_current_health = player_max_health

func show():
	$animation_player.play("fade_in")

func hide():
	$animation_player.play_backwards("fade_in")

func update_health_hud():
	for i in range(10):
		var health_unit = get_node("health_hud/health_unit_%s" % str(i+1))
		if i < player_max_health:
			health_unit.show()
			if i < player_current_health:
				health_unit.healthy()
			else:
				health_unit.unhealthy()
		else:
			health_unit.hide()

func take_damage(amount):
	player_current_health -= amount
	# todo: death stuff
	
	update_health_hud()
	
	if player_current_health <= 0:
		emit_signal("player_death")



