class_name Tile extends Sprite2D 

var definition: TileDefinition

enum Type {
	BrickWall1, 
	CobbleFloor1,
	CobbleFloor2,
	LedderUP,
	LedderDOWN,
	Door1,
}

var type: Type

const tile_types: Dictionary[Tile.Type, Resource] = {
	Tile.Type.BrickWall1: preload("res://resources/tiles/brick_walls_1.tres"),
	Tile.Type.CobbleFloor1: preload("res://resources/tiles/cobble_floor_1.tres"),
	Tile.Type.CobbleFloor2: preload("res://resources/tiles/cobble_floor_2.tres"),
	Tile.Type.LedderUP: preload("res://resources/tiles/ledder_up.tres"),
	Tile.Type.LedderDOWN: preload("res://resources/tiles/ledder_down.tres"),
	Tile.Type.Door1: preload("res://resources/tiles/door_1.tres"),
}

func type_of(type: Type) -> bool: 
	return self.type == type

var is_explored: bool = false:
	set(value):
		is_explored = value
		if is_explored and not visible:
			visible = true

var is_in_view: bool = false:
	set(value):
		is_in_view = value
		modulate = definition.color_lit if is_in_view else definition.color_dark
		if is_in_view and not is_explored:
			is_explored = true
		
func _init(grid_position: Vector2i, tile_type: Type) -> void:
	visible = false
	centered = false
	type = tile_type
	position = Grid.grid_to_world(grid_position)
	scale = Grid.DEFAULT_SCALE
	set_tile_type(tile_type)

func set_tile_type(tile_type: Type) -> void:
	definition = tile_types.get(tile_type)
	texture = definition.texture
	modulate = definition.color_dark
	type = tile_type

func is_walkable() -> bool:
	return definition.is_walkable

func is_transparent() -> bool:
	return definition.is_transparent
