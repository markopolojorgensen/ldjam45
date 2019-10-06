extends Node

func _ready():
	var level_button_container = $parallax_background/parallax_layer_2/level_buttons
	for button_index in range(level_button_container.get_child_count()):
		var button = level_button_container.get_child(button_index)
		button.connect("pressed", self, "level_button_pressed", [button_index + 1])
		if button_index <= (get_parent().levels_beaten):
			button.show()
		

func level_button_pressed(button_index):
	get_parent().change_level(button_index)
	

func _on_quit_button_pressed():
	get_parent().save_game()
	get_tree().quit()

func _process(delta):
	$decorations/MenuCameraFocus.set_focus_position($decorations.get_global_mouse_position() * 0.5)

func _on_fullscreen_button_pressed():
	OS.window_fullscreen = not OS.window_fullscreen

