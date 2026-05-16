class_name Entity extends Sprite2D

enum AIType {
	NONE, 
	HOSTILE
}

enum EntityType {
	CORPSE, 
	ITEM, 
	ACTOR
}

var definition: EntityDefinition
var map_data: MapData
var blocks_movement: bool
var entity_name: String

var fighter_component: FighterComponent
var ai_component: BaseAIComponent

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = Grid.grid_to_world(grid_position)


var type: EntityType:
	set(value):
		type = value
		z_index = type

func _init(map_data: MapData, start_position: Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false
	grid_position = start_position
	scale = Grid.DEFAULT_SCALE
	self.map_data = map_data
	type = entity_definition.type
	set_entity_type(entity_definition)

func set_entity_type(entity_definition: EntityDefinition) -> void:
	self.definition = entity_definition
	self.texture = entity_definition.texture
	self.modulate = entity_definition.color

	self.blocks_movement = self.definition.is_blocking_movement
	self.entity_name = self.definition.name

	match entity_definition.ai_type:
		AIType.HOSTILE:
			self.ai_component = HostileEnemyAIComponent.new()
			self.add_child(self.ai_component)

	if entity_definition.fighter_definition:
		self.fighter_component = FighterComponent.new(entity_definition.fighter_definition)
		self.add_child(self.fighter_component)


func move(move_offset: Vector2i) -> void:
	self.map_data.unregister_blocking_entity(self)
	grid_position += move_offset
	self.map_data.register_blocking_entity(self)


func is_blocking_movement() -> bool:
	return self.blocks_movement


func get_entity_name() -> String:
	return self.entity_name

func is_alive() -> bool: 
	return self.ai_component != null 
