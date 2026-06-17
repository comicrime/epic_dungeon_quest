extends Node 

var map_data: MapData 
var player: Entity 
var player_inventory: Inventory 

func _ready() -> void: 
	MsgBus.map_data_update.connect(self._on_map_data_update)
	MsgBus.player_init.connect(_on_player_init)

func _on_player_init(pl: Entity) -> void:
	self.player = pl
	self.player_inventory = Inventory.new(10, self.player)
	self.add_child(self.player_inventory)
	
func _on_map_data_update(map_data: MapData) -> void: 
	self.map_data = map_data
