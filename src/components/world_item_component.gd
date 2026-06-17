class_name WorldItemComponent extends ItemComponent

@onready var world_item: WorldItem = self.get_parent() as WorldItem

func get_map_data() -> MapData:
	return self.world_item.map_data
