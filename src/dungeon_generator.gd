class_name DungeonGenerator extends Node



@export_category("Content")
@export var entity_types: Dictionary[String, Resource] 
@export var entity_spawn_rates: Dictionary[String, float] 
@export var items: Array[Resource]

@export_category("Map Dimensions")
@export var map_width: int = 100
@export var map_height: int = 45

@export_category("Rooms RNG")
@export var max_rooms: int = 30
@export var room_max_size: int = 15
@export var room_min_size: int = 8

@export_category("Monsters RNG")
@export var max_monsters_per_room: int = 2

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()
	
var player_pos: Vector2i

func generate_dungeon(player:Entity) -> MapData:
	var dungeon: MapData = MapData.new(map_width, map_height, player)
	dungeon.entities.append(player)
	player_pos = Grid.world_to_grid(player.position)
	
	print("player pos: ", player_pos)
	
	var rooms: Array[Rect2i] = []
	var start_room: Rect2i
	for _try_room in max_rooms:
		var room_width: int = _rng.randi_range(room_min_size, room_max_size)
		var room_height: int = _rng.randi_range(room_min_size, room_max_size)
		
		var x: int = _rng.randi_range(0, dungeon.width - room_width - 1)
		var y: int = _rng.randi_range(0, dungeon.height - room_height - 1)
		
		var new_room := Rect2i(x, y, room_width, room_height)
		
		var has_intersections := false
		for room in rooms:
			# Rect2i.intersects() checks for overlapping points. In order to allow bordering rooms one room is shrunk.
			if room.intersects(new_room.grow(-1)):
				has_intersections = true
				break
				
		# TODO: Allow rooms to intersect to build more complext dungeons
		if has_intersections:
			continue
		
		_carve_room(dungeon, new_room)
		
		if rooms.is_empty():
			var room_center: Vector2i = new_room.get_center()
			_place_ledder_up(dungeon, room_center + Vector2i(1,1))
			player.grid_position = room_center
			player.map_data = dungeon
			start_room = new_room
		else:
			_tunnel_between(dungeon, rooms.back(), new_room)
		
		_place_entities(dungeon, new_room)
		rooms.append(new_room)
	
	var breakout: bool
	var out_room: Rect2i
	while !breakout:
		for room in rooms: 
			if room.get_center() == start_room.get_center(): 
				continue 
			if _rng.randf() > 0.7:
				out_room = room 
				breakout = true 
				break
		
	_place_ledder_down(dungeon, out_room.get_center())
	dungeon.setup_pathfinding()
	return dungeon

func _carve_room(dungeon: MapData, room: Rect2i) -> void:
	var inner: Rect2i = room.grow(-1)
	for y in range(inner.position.y, inner.end.y + 1):
		for x in range(inner.position.x, inner.end.x + 1):
			_carve_tile(dungeon, x, y)
		
	#for y in range(room.position.y, inner.end.y + 1):
		#for x in range(room.position.x, room.end.x + 1):
			#
			#var tile: Tile = dungeon.get_tile(Vector2i(x, y))
			#if (tile.definition == dungeon.tile_types.get(MapData.TileType.CobbleFloor1) || 
			#tile.definition == dungeon.tile_types.get(MapData.TileType.CobbleFloor2)): 
				#_place_door(dungeon, Vector2i(x, y))
					

func _tunnel_horizontal(dungeon: MapData, y: int, x_start: int, x_end: int) -> void:
	var x_min: int = mini(x_start, x_end)
	var x_max: int = maxi(x_start, x_end)
	for x in range(x_min, x_max + 1):
		_carve_tile(dungeon, x, y)

func _tunnel_vertical(dungeon: MapData, x: int, y_start: int, y_end: int) -> void:
	var y_min: int = mini(y_start, y_end)
	var y_max: int = maxi(y_start, y_end)
	for y in range(y_min, y_max + 1):
		_carve_tile(dungeon, x, y)

func _tunnel_between(dungeon: MapData, start_room: Rect2i, end_room: Rect2i) -> void:
	var start: Vector2i = start_room.get_center()
	var end: Vector2i = end_room.get_center()
	#var start: Vector2i = _adjust_center_randomly(start_room)
	#var end: Vector2i = _adjust_center_randomly(end_room)
	
	if _rng.randf() < 0.5:
		_tunnel_horizontal(dungeon, start.y, start.x, end.x)
		_tunnel_vertical(dungeon, end.x, start.y, end.y)
	else:
		_tunnel_vertical(dungeon, start.x, start.y, end.y)
		_tunnel_horizontal(dungeon, end.y, start.x, end.x)

func _adjust_center_randomly(room: Rect2i) -> Vector2i: 
	var adjusted_y: int = _rng.randi_range(room.position.y, room.end.y)
	var adjusted_x: int = _rng.randi_range(room.position.x, room.end.x)
	return Vector2i(adjusted_x, adjusted_y)

func _carve_tile(dungeon: MapData, x: int, y: int) -> void:
		var tile_position = Vector2i(x, y)
		var tile: Tile = dungeon.get_tile(tile_position)
		tile.set_tile_type(dungeon.floor_type(self._rng))

func _place_entities(dungeon: MapData, room: Rect2i) -> void:
	var number_of_monsters: int = _rng.randi_range(0, max_monsters_per_room)
	
	for _i in number_of_monsters:
		var x: int = _rng.randi_range(room.position.x + 1, room.end.x - 1)
		var y: int = _rng.randi_range(room.position.y + 1, room.end.y - 1)
		var new_entity_position := Vector2i(x, y)
		
		var can_place = true
		for entity in dungeon.entities:
			if entity.grid_position == new_entity_position:
				can_place = false
				break
		
		if can_place:
			for eid in self.entity_types.keys(): 
				if _rng.randf() >= self.entity_spawn_rates[eid]:
					dungeon.entities.append(Entity.new(dungeon, new_entity_position, entity_types.get(eid)))

func _place_ledder_up(dungeon: MapData, pos: Vector2i) -> void:
	var tile: Tile = dungeon.get_tile(pos)
	tile.set_tile_type(dungeon.get_ledder(true))
	
func _place_ledder_down(dungeon: MapData, pos: Vector2i) -> void: 
	var tile: Tile = dungeon.get_tile(pos)
	tile.set_tile_type(dungeon.get_ledder(false))

func _place_door(dungeon: MapData, pos: Vector2i) -> void: 
	var tile: Tile = dungeon.get_tile(pos)
	tile.set_tile_type(dungeon.get_door())
