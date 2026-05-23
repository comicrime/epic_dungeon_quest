class_name MainMenuUI 
extends MarginContainer

func _on_new_game_pressed():
	MsgBus.game_requested.emit(true)
