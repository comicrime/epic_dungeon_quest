extends Node
class_name PickableComponent

@export var obj_ref: Node
@export var area2d: Area2D
@export var pickable_checker: PickChecker

func _ready() -> void:
	print("pickable ready: ", area2d == null)
	area2d.body_entered.connect(_on_body_entered)
	print(area2d.body_entered.is_connected(_on_body_entered))

func pre_process(actor: PickerComponent) -> void:
	print("[PC][pre_process]")
	if pickable_checker.check(obj_ref):
		print("[PC][pre_process] can_be_picked: true")
		actor.pick_item(self.obj_ref as Item)
		return 
	
	return 
	
func process(actor) -> void:
	return 
	
func post_process(actor) -> void:
	return 

func _on_body_entered(body: Node2D) -> void: 
	MsgBus.player_pickable_cb.emit(self)
