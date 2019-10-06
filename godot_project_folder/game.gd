extends Node

var level_scenes = [
	preload("res://main_menu.tscn"),
	preload("res://level_1.tscn"),
	preload("res://level_2.tscn"),
	preload("res://level_3.tscn"),
	preload("res://level_4.tscn"),
	preload("res://level_5.tscn"),
]

var current_level_instance

var levels_beaten = 0

func _ready():
	# wait for logo to play
	yield(get_tree().create_timer(1.6), "timeout")
	
	var save_data = load_save_game()
	if not save_data:
		$sense_self/control/sense_of_self_animation.play("fade_in")
	else:
		levels_beaten = save_data["levels_beaten"]
		_on_sense_of_self_acknowledged_button_pressed()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		save_game()
		get_tree().quit()

func level_beaten(level):
	print("beat level %s" % str(level))
	if levels_beaten < level:
		print("  new highest level beaten!")
		levels_beaten = level
		save_game()

func change_level(level):
	print("switching to level %s" % str(level))
	$game_eyelid/eyelid_animation.play_backwards("open_eyes")
	yield(get_tree().create_timer(0.5), "timeout")
	
	# main menu
	if level != 0:
		# print("not main menu, killing music")
		$music_manager.stop()
	
	if current_level_instance:
		# print("deleting current level")
		# current_level_instance.prepare_to_die()
		current_level_instance.queue_free()
	
	# print("adding new level")
	current_level_instance = level_scenes[level].instance()
	add_child(current_level_instance)
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	$game_eyelid/eyelid_animation.play("open_eyes")
	
	# main menu
	if level == 0:
		# print("playing main menu music")
		$music_manager.play(levels_beaten)

func _on_sense_of_self_acknowledged_button_pressed():
	change_level(0)
	$sense_self.queue_free()
	save_game()

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_data = {
		"sense_of_self_acknowledged": true,
		"levels_beaten": levels_beaten,
	}
	save_game.store_line(to_json(save_data))
	save_game.close()

func load_save_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	save_game.open("user://savegame.save", File.READ)
	var save_data = parse_json(save_game.get_line())
	return save_data




