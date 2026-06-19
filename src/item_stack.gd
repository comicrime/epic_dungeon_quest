class_name Stack extends RefCounted 

var item_id: String
var stack_item: Item 
var stack_size: int
var max_size: int

func _init(lmax_size: int = 1) -> void: 
	self.max_size = lmax_size

func size() -> int: 
	return self.stack_size

func append(item: Item) -> bool: 
	if !self.stack_item: 
		self._upd_stack(item)
		
	if self.size() > 0:
		if item.item_id != self.item_id: 
			return false
	else: 
		self.item_id = item.item_id
		
	if self.size() + 1 > max_size: 
		return false 
	self.stack_size += 1
	return true

func append_n(item: Item, amount: int) -> bool:
	if amount <= 0: 
		return true
		
	if self.size() > 0:
		if item.item_id != self.item_id: 
			return false
	else: 
		self.item_id = item.item_id
		
	if self.size() + amount > max_size: 
		return false 
	self.stack_size += amount
	return true
	
func pop() -> Item: 
	if self.size() == 0: 
		return null 
	if self.size() == 1: 
		self.clear()
	return self.stack_item.duplicate_item()
	
func clear() -> void: 
	self.item_id = ""
	self.stack_item = null 
	self.max_size = 0 
	self.stack_size = 0

func _upd_stack(item: Item) -> void: 
	self.max_size = item.definition.max_stack 
	self.item_id = item.item_id 
	self.stack_item = item
