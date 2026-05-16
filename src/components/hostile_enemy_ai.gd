class_name HostileEnemyAIComponent extends BaseAIComponent 

var path: Array = [] 

func perform() -> void:
	var target: Entity = self.get_map_data().player 
	var target_grid_position: Vector2i = target.grid_position 
	var offset: Vector2i = target_grid_position - self.entity.grid_position 
	var distance: int = max(abs(offset.x), abs(offset.y))

	if self.get_map_data().get_tile(self.entity.grid_position).is_in_view:
		if distance <= 1:
			return MeleeAction.new(self.entity, offset.x, offset.y).perform()

		path = get_point_path_to(target_grid_position)
		path.pop_front()

	if !path.is_empty():
		var destination := Vector2i(path[0])
		if self.get_map_data().get_blocking_entity_at_location(destination):
			return WaitAction.new(entity).perform()

		path.pop_front()
		var move_offset: Vector2i = destination - self.entity.grid_position
		return MovementAction.new(entity, move_offset.x, move_offset.y).perform()

	return WaitAction.new(entity).perform()
