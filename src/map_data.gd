class_name MapData

# Map model

enum TileType {
	BrickWall1, 
	CobbleFloor1,
	CobbleFloor2
}

const tile_types: Dictionary[TileType, Resource] = {
	TileType.BrickWall1: preload("res://resources/tiles/brick_walls_1.tres"),
	TileType.CobbleFloor1: preload("res://resources/tiles/cobble_floor_1.tres"),
	TileType.CobbleFloor2: preload("res://resources/tiles/cobble_floor_2.tres")
}

const _cobbles_spawnrate: float = 0.8
const entity_pathfinding_weight: float = 10.0

func floor_type(rng: RandomNumberGenerator) -> Resource:
	if rng.randf() <= _cobbles_spawnrate:
		return tile_types.get(TileType.CobbleFloor1)

	return tile_types.get(TileType.CobbleFloor2)

var width: int
var height: int
var tiles: Array[Tile]
var entities: Array[Entity]

var player: Entity

var pathfinder: AStarGrid2D

func _init(map_width: int, map_height: int, p: Entity) -> void:
	width = map_width
	height = map_height
	
	self.player = p

	entities = []
	_setup_tiles()

func _setup_tiles() -> void:
	tiles = []
	for y in height:
		for x in width:
			var tile_position := Vector2i(x, y)
			var tile := Tile.new(tile_position, tile_types.get(TileType.BrickWall1))
			tiles.append(tile)

func is_in_bounds(coordinate: Vector2i) -> bool:
	return (
		0 <= coordinate.x
		and coordinate.x < width
		and 0 <= coordinate.y
		and coordinate.y < height
	)

func get_tile_xy(x: int, y: int) -> Tile:
	return get_tile(Vector2i(x, y))

func get_tile(grid_position: Vector2i) -> Tile:
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null

	return tiles[tile_index]

func get_blocking_entity_at_location(grid_position: Vector2i) -> Entity:
	for entity in entities:
		if entity.is_blocking_movement() and entity.grid_position == grid_position:
			return entity

	return null

func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
		
	return grid_position.y * width + grid_position.x

func register_blocking_entity(entity: Entity) -> void:
	self.pathfinder.set_point_weight_scale(entity.grid_position, entity_pathfinding_weight) 

func unregister_blocking_entity(entity: Entity) -> void:
	self.pathfinder.set_point_weight_scale(entity.grid_position, 0)

func setup_pathfinding() -> void:
	self.pathfinder = AStarGrid2D.new()
	self.pathfinder.region = Rect2i(0, 0, width, height)
	self.pathfinder.update()

	for y in self.height:
		for x in self.width:
			var grid_position := Vector2i(x, y)
			var tile: Tile = self.get_tile(grid_position)

			self.pathfinder.set_point_solid(grid_position, !tile.is_walkable())

	for entity in self.entities:
		if entity.is_blocking_movement():
			self.register_blocking_entity(entity)

func get_actors() -> Array[Entity]:
	var actors: Array[Entity] = [] 
	for entity in self.entities:
		if entity.is_alive():
			actors.append(entity) 
	return actors

func get_actor_at_location(location: Vector2i) -> Entity:
	for actor in self.get_actors():
		if actor.grid_position == location:
			return actor 
		
	return null
