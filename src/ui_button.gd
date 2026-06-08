class_name UIButton
extends Button

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed() -> void:
	MsgBus.sound_event.emit("ui_button")
