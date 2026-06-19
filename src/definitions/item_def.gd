class_name ItemDefinition extends Resource 

@export_category("System")
@export var item_id:String

@export_category("Visuals")
@export var name: String = "NONAME"
@export var texture: AtlasTexture
@export_color_no_alpha var color: Color = Color.WHITE 

@export_category("Mechanics")
@export var max_stack: int = 1

@export_category("Components")
@export var weapon_component: WeaponComponentDefinition
@export var consumable_component: ConsumableComponentDefinition
