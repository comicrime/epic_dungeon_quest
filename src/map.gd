class_name Map extends Node2D 

var map_data: MapData

@onready var items: Node2D  = $Items
@onready var tiles: Node2D = $Tiles
@onready var entities: Node2D = $Entities
@onready var dungeon_generator: DungeonGenerator = $DungeonGenerator
@onready var field_of_view: FieldOfView = $FOV

@export var fov_radius: int = 8

func _ready(): 
	MsgBus.dwell.connect(_on_dwell)

func generate(player: Entity) -> void:
	MsgBus.sound_event.emit("dwell")
	clear_dungeon()
	map_data = dungeon_generator.generate_dungeon(player)
	self.add_child(map_data)
	MsgBus.map_data_update.emit(map_data)
	_place_tiles()
	_place_entities()
	_place_items()

func _on_dwell(player: Entity) -> void: 
	self.generate(player)

func update_fov(player_position: Vector2i) -> void:
	self.field_of_view.update_fov(self.map_data, player_position, self.fov_radius)
	
	for entity in map_data.entities:
		entity.visible = map_data.get_tile(entity.grid_position).is_in_view
	for item: Item in map_data.items: 
		if item.interactable:
			item.visible = map_data.get_tile(item.grid_position).is_in_view

func _place_tiles() -> void:
	for tile in map_data.tiles:
		tiles.add_child(tile)

func _place_entities() -> void:
	for entity in map_data.entities:
		entities.add_child(entity)
		
func _place_items() -> void: 
	for item in map_data.items: 
		items.add_child(item)

func clear_dungeon() -> void: 
	map_data = null
	for e: Entity in entities.get_children():
		if e.is_player: 
			continue
		e.queue_free()
		
	for t in tiles.get_children():
		t.queue_free()
		
	for i in items.get_children():
		i.queue_free()
	
	
	
	
	
	
	
	
	
