extends WithInventory

var animation_speed = 10
var moving = false
var tile_size = 16

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var picker_component = $PickerComponent

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
	# Sub to signals 
	MsgBus.player_pickable_cb.connect(_on_player_pickable_interaction)

func _physics_process(_delta):
	for dir in inputs.keys():
		if moving == false:
			if Input.is_action_pressed(dir):
				move_and_slide()
				await move(dir)
				moving = false

func move(dir):
	#position += inputs[dir] * tile_size
	var tween = create_tween()
	tween.tween_property(self, "position",
		position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_LINEAR)
	moving = true
	await tween.finished

func get_inventory() -> Array[Item]:
	return PlayerState.inventory

func _on_player_pickable_interaction(pickable: PickableComponent) -> void: 
	pickable.pre_process(self.picker_component)
	print(PlayerState.inventory)
