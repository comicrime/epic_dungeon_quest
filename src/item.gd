class_name Item extends Sprite2D

enum ItemType {
	UNKNOWN, 
}

var item_name: String
var definition: ItemDefinition = null 
var max_stack: int
var interactable: bool = true

var type: ItemType:
	set(value):
		type = value
		z_index = type

func _init(def: ItemDefinition, item_type: ItemType, lmax_stack: int = 64) -> void: 
	self.definition = def 
	self.type = item_type
	self.set_item_def(def)
	self.max_stack = lmax_stack

func _ready() -> void: 
	pass

func _process(_delta: float) -> void: 
	pass

func _physics_process(_delta: float) -> void:
	pass

func set_item_def(item_definition: ItemDefinition) -> void:
	self.definition = item_definition
	self.texture = item_definition.texture
	self.modulate = item_definition.color
	self.item_name = self.definition.name

func duplicate_item() -> Item: 
	var new_item: Item = Item.new(definition, type, max_stack)
	return new_item
