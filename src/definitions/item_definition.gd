class_name ItemDefinition extends Resource 

@export_category("Visuals")
@export var name: String = "NONAME"
@export var texture: AtlasTexture
@export_color_no_alpha var color: Color = Color.WHITE 

@export_category("Mechanics")
#@export 

@export_category("Components")
@export var fighter_definition: FighterComponentDefinition
@export var ai_type: Entity.AIType
