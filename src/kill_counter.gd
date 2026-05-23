extends Label

func _ready() -> void:
	MsgBus.kill_inc.connect(_on_kill_inc)
	
func _on_kill_inc(inc: int) -> void: 
	var current_counter: int = int(self.text)
	var new_counter: int = current_counter - inc 
	self.text = str(new_counter)
	if new_counter <= 0: 
		MsgBus.game_win.emit()
