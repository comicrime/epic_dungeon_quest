class_name Component extends Node 

@onready var entity: Entity = self.get_parent() as Entity 

func get_map_data() -> MapData:
	return self.entity.map_data
	
