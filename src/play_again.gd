extends Button

func _ready(): 
	self.pressed.connect(_on_press)
	
func _on_press() -> void: 
	MsgBus.game_requested.emit(true)
