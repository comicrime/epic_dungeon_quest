class_name PickupAction extends ActionWithDirection

var item: Item 

func _init(entity: Entity, dx: int, dy: int, litem: Item) -> void: 
	self.item = litem
	super._init(entity, dx, dy)   

func perform() -> void: 
	print("pickup!")
	MsgBus.item_pickup.emit(self.item, self.entity)
