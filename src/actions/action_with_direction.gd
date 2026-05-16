class_name ActionWithDirection extends Action 

var offset: Vector2i 

func _init(entity: Entity, dx: int, dy: int) -> void:
	self.offset = Vector2i(dx, dy)
	super._init(entity)

func get_destination() -> Vector2i:
	return self.entity.grid_position + offset

func get_blocking_entity_at_destination() -> Entity:
	return self.get_map_data().get_blocking_entity_at_location(self.get_destination())

func get_target_actor() -> Entity:
	return self.get_map_data().get_actor_at_location(self.get_destination())
