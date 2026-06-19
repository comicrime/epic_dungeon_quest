extends Control

@onready var music_volume_bar: ProgressBar = %MusicVolumeBar
@onready var sfx_volume_bar: ProgressBar = %SfxVolumeBar

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		MsgBus.main_menu_requested.emit(true)


func _on_low_pressed():
	if music_volume_bar.value == 0:
		return
	music_volume_bar.value -= 5
	MsgBus.sound_event.emit("sound_quiter")


func _on_up_pressed():
	if music_volume_bar.value == 100:
		return
	music_volume_bar.value += 5
	MsgBus.sound_event.emit("sound_louder")


func _on_sfx_up_pressed():
	if sfx_volume_bar.value == 100:
		return
	sfx_volume_bar.value += 5
	MsgBus.sound_event.emit("sfx_sound_louder")


func _on_sfx_low_pressed():
	if sfx_volume_bar.value == 0:
		return
	sfx_volume_bar.value -= 5
	MsgBus.sound_event.emit("sfx_sound_quiter")
