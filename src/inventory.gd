class_name Inventory 
extends Node

var entity: Entity

var size: int   

var slots: Array[Stack]

func _init(invsize: int, entity: Entity) -> void: 
	self.size = invsize 
	self.slots.resize(invsize)
	for i in range(self.slots.size()): 
		var stack = Stack.new([], 1)
		self.slots[i] = stack
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

func _on_item_pickup(i: Item, actor: Entity) -> void: 
	var item: Item = i.duplicate_item()
	if append_item_if_possible(item):
		MsgBus.item_pickup_confirm.emit(i)
		MessageLog.send_message("You picked up a " + item.item_name, GameColors.WELCOME_TEXT)
		MsgBus.sound_event.emit("pickup")
	print_debug("inventory slots: ", self.slots, " size: ", slots.size())

func _on_item_used(item: Item, actor: Entity) -> void: 
	pass
	
func _on_item_update(item: Item, actor: Entity) -> void: 
	pass

func append_item_if_possible(item: Item) -> bool: 
	var new_stack: bool
	var selected_slot: Stack
	var first_empty_stack: Stack 
	for stack in self.slots: 
		if !first_empty_stack and (!stack or stack.size() <= 0): 
			first_empty_stack = stack 
			continue 
		
		if stack.item_id != item.item_id and stack.size() > 0: 
			continue
		selected_slot = stack 
		break
	
	if !selected_slot: 
		if first_empty_stack:
			selected_slot = first_empty_stack
		else: 
			return false
		
	selected_slot.append(item)
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
	
