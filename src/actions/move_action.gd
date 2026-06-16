class_name MovementAction extends ActionWithDirection 

func perform() -> void:
	var map_data: MapData = self.get_map_data()
	var destination_tile: Tile = map_data.get_tile(self.get_destination())

	if not destination_tile or not destination_tile.is_walkable():
		return

	if self.get_blocking_entity_at_destination():
		return 

	entity.move(offset)
		
	if entity.is_player: 
		if destination_tile.definition.type == "LEDDER_DOWN": 
			print("dwell!")
			MsgBus.dwell.emit(entity)
