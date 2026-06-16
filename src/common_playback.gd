extends AudioStreamPlayer

const click_sound = preload("res://assets/sounds/snd_click.mp3")
const atk_sound = preload("res://assets/sounds/snd_hit.mp3")
const dwell_sound = preload("res://assets/sounds/snd_descend.mp3")


func _ready() -> void:
	MsgBus.sound_event.connect(_on_sound_event)
	
func _on_sound_event(ui_id: String) -> void: 
	print(ui_id)
	match ui_id: 
		"ui_button":
			ui_button_press_playback() 
		"attack":
			attack_playback()
		"player_death":
			pass 
		"dwell":
			dwell_playback()

func ui_button_press_playback() -> void: 
	self.stream = click_sound
	self.play(0)

func attack_playback() -> void: 
	self.stream = atk_sound
	self.play(0)

func dwell_playback() -> void: 
	self.stream = dwell_sound
	self.play(0)
	
