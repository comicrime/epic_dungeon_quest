class_name Item extends Sprite2D



var item_id: String:
	set(value):
		item_id = value
var item_name: String
var definition: ItemDefinition = null 
var max_stack: int
var interactable: bool = true


func _init(def: ItemDefinition) -> void: 
	self.definition = def 
	self.set_item_def(def)

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
	self.item_name = item_definition.name
	self.item_id = item_definition.item_id
	self.max_stack = item_definition.max_stack

func duplicate_item() -> Item: 
	var new_item: Item = Item.new(definition)
	return new_item
