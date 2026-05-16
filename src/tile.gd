class_name Tile extends Sprite2D 

var definition: TileDefinition

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
		
func _init(grid_position: Vector2i, tile_definition: TileDefinition) -> void:
	visible = false
	centered = false
	position = Grid.grid_to_world(grid_position)
	scale = Grid.DEFAULT_SCALE
	set_tile_type(tile_definition)

func set_tile_type(tile_definition: TileDefinition) -> void:
	definition = tile_definition
	texture = definition.texture
	modulate = definition.color_dark

func is_walkable() -> bool:
	return definition.is_walkable

func is_transparent() -> bool:
	return definition.is_transparent
