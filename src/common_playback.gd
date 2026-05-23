extends AudioStreamPlayer

func _ready() -> void:
	MsgBus.ui_press.connect(_on_ui_press)
	
func _on_ui_press(ui_id: String) -> void: 
	match ui_id: 
		"ui_button":
			ui_button_press_playback() 

func ui_button_press_playback() ->void: 
	self.play(0)
