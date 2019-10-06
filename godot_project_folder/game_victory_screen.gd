extends CanvasLayer

func fade_in():
	$animation_player.play("fade_in")

func _on_button_pressed():
	get_parent().return_to_main_menu()


