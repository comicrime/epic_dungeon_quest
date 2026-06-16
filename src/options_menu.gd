extends Control

@onready var volume_bar: ProgressBar = %VolumeBar

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		MsgBus.main_menu_requested.emit(true)


func _on_low_pressed():
	if volume_bar.value == 0:
		return
	volume_bar.value -= 5
	MsgBus.sound_event.emit("sound_quiter")


func _on_up_pressed():
	if volume_bar.value == 100:
		return
	volume_bar.value += 5
	MsgBus.sound_event.emit("sound_louder")
