extends UIButton

func _on_pressed() -> void:
	print_debug("_on_new_game_pressed")
	MsgBus.game_requested.emit(true)
