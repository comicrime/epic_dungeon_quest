class_name UIButton
extends Button

@onready var sfx_player = %SFX

func _ready():
	self.pressed.connect(self._on_pressed)

func _on_pressed() -> void:
	sfx_player.play()
