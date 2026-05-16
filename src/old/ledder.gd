extends Sprite2D

@export var next_level: int 

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	print("body entered ledder")
	MsgBus.player_level_transition.emit(next_level)
