extends BaseInputHandler

const directions = {
	"up": Vector2i.UP,
	"down": Vector2i.DOWN,
	"left": Vector2i.LEFT,
	"right": Vector2i.RIGHT,
	#"move_up_left": Vector2i.UP + Vector2i.LEFT,
	#"move_up_right": Vector2i.UP + Vector2i.RIGHT,
	#"move_down_left": Vector2i.DOWN + Vector2i.LEFT,
	#"move_down_right": Vector2i.DOWN + Vector2i.RIGHT,
}

@onready var camera_2d = %Camera2D
@onready var game = %Game

var movement_target: Vector2

func get_action(player: Entity) -> Action:
	var action: Action = null
	
	if Input.is_action_just_pressed("wheel_up"): 
		MsgBus.zoom.emit(1)
	if Input.is_action_just_pressed("wheel_down"): 
		MsgBus.zoom.emit(-1)
	
	if Input.is_action_just_pressed("left_click"): 
		print("left click")
		
		var mouse_pos: Vector2 = game.get_global_mouse_position()
		print("mouse pos: ", mouse_pos)
		
		var grid_pos := Grid.world_to_grid(mouse_pos)
		var tile = GlobalManager.map_data.get_tile(grid_pos)
		print("tile pos: ", tile.position)

		mouse_pos = grid_pos
	
	for direction in directions:
		if Input.is_action_just_pressed(direction):
			var offset: Vector2i = directions[direction]
			action = BumpAction.new(player, offset.x, offset.y)
	
	#if Input.is_action_just_pressed("wait"):
		#action = WaitAction.new(player)
		#
	#if Input.is_action_just_pressed("view_history"):
		#get_parent().transition_to(InputHandler.InputHandlers.HISTORY_VIEWER)
	
	if Input.is_action_just_pressed("esc"):
		action = EscapeAction.new(player)
	
	return action
