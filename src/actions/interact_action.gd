class_name InteractAction extends ActionWithDirection

func perform() -> void:
	var target: Tile = get_target_tile()
	if not target:
		return
	
func get_target_tile() -> Tile: 
	return self.get_map_data().get_tile_at_location(self.get_destination())
