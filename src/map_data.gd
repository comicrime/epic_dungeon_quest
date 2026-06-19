class_name MapData
extends Node
# Map model

enum TileType {
	BrickWall1, 
	CobbleFloor1,
	CobbleFloor2,
	LedderUP,
	LedderDOWN,
	Door1,
	Chasm, 
	InnerChasm,
	SilverChest,
	TallGrass,
}

const tile_types: Dictionary[TileType, Resource] = {
	TileType.BrickWall1: preload("res://resources/tiles/brick_walls_1.tres"),
	TileType.CobbleFloor1: preload("res://resources/tiles/cobble_floor_1.tres"),
	TileType.CobbleFloor2: preload("res://resources/tiles/cobble_floor_2.tres"),
	TileType.LedderUP: preload("res://resources/tiles/ledder_up.tres"),
	TileType.LedderDOWN: preload("res://resources/tiles/ledder_down.tres"),
	TileType.Door1: preload("res://resources/tiles/door_1.tres"),
	TileType.Chasm: preload("res://resources/tiles/chasm.tres"), 
	TileType.InnerChasm: preload("res://resources/tiles/inner_chasm.tres"),
	TileType.SilverChest: preload("res://resources/tiles/silver_chest.tres"),
	TileType.TallGrass: preload("res://resources/tiles/tall_grass.tres")
}

const _cobbles_spawnrate: float = 0.8
const entity_pathfinding_weight: float = 10.0
const _chasm_spawnrate: float = 0.2
const _tall_grass_spawn_rate: float = 0.03

const _silver_chest_spawn_rate: float = 0.005 #DBG, change to 0.0...

var level:int

func floor_type(
	rng: RandomNumberGenerator, 
	with_chasms: bool = false, 
	with_chests: bool = false,
) -> Resource:
	if rng.randf() <= _tall_grass_spawn_rate:
		return tile_types.get(TileType.TallGrass) 
	if rng.randf() <= _silver_chest_spawn_rate and with_chests:
		return tile_types.get(TileType.SilverChest) 
	if rng.randf() <= _chasm_spawnrate and with_chasms:
		return tile_types.get(TileType.Chasm)
	if rng.randf() <= _cobbles_spawnrate:
		return tile_types.get(TileType.CobbleFloor1)
		

	return tile_types.get(TileType.CobbleFloor2)

func get_ledder(up: bool) -> Resource: 
	if up: 
		return tile_types.get(TileType.LedderUP) 
	return tile_types.get(TileType.LedderDOWN)

func get_door() -> Resource: 
	return tile_types.get(TileType.Door1)

var width: int
var height: int
var tiles: Array[Tile]
var entities: Array[Entity]
var items: Array[WorldItem]

var player: Entity

var pathfinder: AStarGrid2D

func _init(level:int, map_width: int, map_height: int, p: Entity) -> void:
	width = map_width
	height = map_height
	
	self.player = p
	self.level = level
	entities = []
	_setup_tiles()

func _ready() -> void: 
	print_debug("map_data is ready")
	MsgBus.item_pickup_confirm.connect(_on_item_pickup_confirm)

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
	
func get_tiles() -> Array[Tile]: 
	return self.tiles

func get_items() -> Array[WorldItem]: 
	return self.items

func get_actor_at_location(location: Vector2i) -> Entity:
	for actor in self.get_actors():
		if actor.grid_position == location:
			return actor 
		
	return null

func get_tile_at_location(location: Vector2i) -> Tile:
	for tile in self.get_tiles():
		if Grid.world_to_grid(tile.global_position) == location:
			return tile 
	return null

func get_item_at_location(location: Vector2i) -> WorldItem:
	for item in self.get_items():
		if Grid.world_to_grid(item.global_position) == location:
			return item 
	return null

func _on_item_pickup_confirm(item: Item) -> void: 
	var new_arr: Array[WorldItem] 
	for map_item: Item in self.items: 
		
		if !map_item:
			continue
		if map_item != item: 
			new_arr.append(map_item as WorldItem)
			continue
			
		map_item.interactable = false
		map_item.visible = false
		map_item.free()
		
	self.items = new_arr
