class_name Inventory 
extends Node

var entity: Entity

var size: int   

var slots: Array[Stack]

func _init(invsize: int, entity: Entity) -> void: 
	self.size = invsize 
	self.slots.resize(invsize)
	self.entity = entity

func _ready() -> void: 
	MsgBus.item_pickup.connect(item_callback_mw(_on_item_pickup))
	MsgBus.item_update.connect(item_callback_mw(_on_item_update))
	MsgBus.item_used.connect(item_callback_mw(_on_item_used))

func item_callback_mw(cb: Callable) -> Callable: 
	return func(item: Item, actor: Entity): 
		if actor != self.entity: 
			return 
		cb.call(item, actor)

func _on_item_pickup(item: Item, actor: Entity) -> void: 
	var litem: Item = item.duplicate_item()
	MsgBus.item_pickup_confirm.emit(item)
	MessageLog.send_message("You picked up a " + litem.item_name, GameColors.WELCOME_TEXT)
	pass

func _on_item_used(item: Item, actor: Entity) -> void: 
	pass
	
func _on_item_update(item: Item, actor: Entity) -> void: 
	pass

func append_item_if_possible(item: Item) -> bool: 
	if slots.size() >= size: 
		return false 
	slots.append(item)
	return true

func set_item(item: Item, idx: int) -> Item: 
	var item_at_idx: Item = slots.get(idx) 
	self.slots.set(idx, item)
	return item_at_idx

func get_item(idx: int) -> Item: 
	return slots.get(idx) 
	
func pick_item(idx: int) -> Item: 
	var item_at_idx: Item = slots.get(idx) 
	self.slots.set(idx, null)
	return item_at_idx

func clear_slots() -> void: 
	self.slots.clear()
	
