class_name PickerComponent
extends Node

@export var obj_ref: WithInventory

func pick_item(item: Item) -> void:
	obj_ref.get_inventory().append(item)
