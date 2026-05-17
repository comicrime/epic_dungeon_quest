extends Node 

var map_data: MapData 

func _ready() -> void: 
	MsgBus.map_data_update.connect(self._on_map_data_update)
	
func _on_map_data_update(map_data: MapData) -> void: 
	self.map_data = map_data
