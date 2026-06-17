class_name Stack extends RefCounted 

var items: Array[Item]
var max_size: int

func _init(arr: Array[Item], lmax_size: int) -> void: 
	self.items = arr 
	self.max_size = lmax_size

func size() -> int: 
	return items.size()

func append(item: Item) -> bool: 
	if self.items.size() + 1 > max_size: 
		return false 
	self.items.append(item)
	return true

func append_n(arr: Array[Item]) -> bool:
	if self.items.size() + arr.size() > max_size: 
		return false 
	self.items.append_array(arr)
	return true
	
func pop() -> Item: 
	if self.items.size() == 0: 
		return null 
	return self.items.pop_back()
