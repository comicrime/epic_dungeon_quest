class_name Grid 
extends Object

const _DEFAULT_SCALE_FACTOR: int = 1
const DEFAULT_SCALE: Vector2 = Vector2(_DEFAULT_SCALE_FACTOR, _DEFAULT_SCALE_FACTOR)
const tile_size:Vector2i = Vector2i(16 * _DEFAULT_SCALE_FACTOR, 16 * _DEFAULT_SCALE_FACTOR) 

static func grid_to_world(grid_pos:Vector2i) -> Vector2i:
	return grid_pos * tile_size 

static func world_to_grid(world_pos:Vector2i) -> Vector2i:
	return world_pos / tile_size
