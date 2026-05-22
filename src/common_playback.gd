extends AudioStreamPlayer

func _on_new_game_pressed():
	ui_button_press_playback()

func _on_options_pressed():
	ui_button_press_playback()

func _on_exit_pressed():
	ui_button_press_playback()

func ui_button_press_playback() ->void: 
	self.play(0)
