class_name UIButton
extends Button

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed() -> void:
	MsgBus.ui_press.emit("ui_button")
