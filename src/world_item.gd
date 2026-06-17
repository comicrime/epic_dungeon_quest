class_name WorldItem extends Item

var map_data: MapData
var blocks_movement: bool

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = Grid.grid_to_world(grid_position)

func _init(def: ItemDefinition, item_type: ItemType, pos: Vector2i) -> void: 
	super(def, item_type)
	self.grid_position = pos 
	centered = false
	scale = Grid.DEFAULT_SCALE
	self.map_data = map_data
	
# override
func _ready() -> void: 
	pass

# override
func _process(_delta: float) -> void: 
	if self.get_parent() == null: 
		self.queue_free()

# override
func _physics_process(_delta: float) -> void:
	pass
	
