extends AudioStreamPlayer

var sound_level: float = 100

func _ready() -> void:
	MsgBus.sound_event.connect(_on_sound_event)
	
func _on_sound_event(ui_id: String) -> void: 
	match ui_id: 
		"sound_louder":
			sound_level_change(5)
		"sound_quiter":
			sound_level_change(-5)

func sound_level_change(delta: float) -> void: 
	if sound_level == 0 and sound_level + delta > 0: 
		play()
	sound_level += delta
	
	if sound_level == 0: 
		stop()
		return
	self.volume_db += delta
