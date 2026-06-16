class_name BumpAction extends ActionWithDirection 

func perform() -> void: 
	var destination := Vector2i(self.entity.grid_position + offset)
	
	if self.get_target_actor():
		MsgBus.sound_event.emit.call_deferred("attack")
		MeleeAction.new(self.entity, offset.x, offset.y).perform()
	#elif self.get_target_tile():
		#MsgBus.sound_event.emit.call_deferred("tile")
	else:
		MovementAction.new(self.entity, offset.x, offset.y).perform()
