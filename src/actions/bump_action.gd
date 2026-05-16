class_name BumpAction extends ActionWithDirection 

func perform() -> void: 
	var destination := Vector2i(self.entity.grid_position + offset)
	
	if self.get_target_actor():
		MeleeAction.new(self.entity, offset.x, offset.y).perform()
	else:
		MovementAction.new(self.entity, offset.x, offset.y).perform()
