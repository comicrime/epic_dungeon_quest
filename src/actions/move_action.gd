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
		
		# BRUH
		var pos: Vector2i = Vector2i(self.entity.grid_position.x, self.entity.grid_position.y)
		var item: WorldItem = self.get_map_data().get_item_at_location(pos)
		if item and item.interactable: 
			var pickup_action: PickupAction = PickupAction.new(entity, pos.x, pos.y, item)
			pickup_action.perform()
