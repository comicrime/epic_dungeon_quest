extends Node

const game_scene: PackedScene = preload("res://scenes/game.tscn")
const main_menu_scene: PackedScene = preload("res://scenes/main_menu_ui.tscn")

var current_child: Node

func _ready():
	print("TEST")
	load_main_menu()

func load_main_menu() -> void:
	var main_menu = switch_to_scene(main_menu_scene)
	MsgBus.game_requested.connect(_on_game_requested)

func switch_to_scene(scene: PackedScene) -> Node:
	if current_child != null:
		current_child.queue_free()
	current_child = scene.instantiate()
	add_child(current_child)
	return current_child

func _on_game_requested(try_load: bool) -> void:
	var game: DungeonGame = switch_to_scene(game_scene)
	#game.main_menu_requested.connect(load_main_menu)
	#if try_load:
		#game.load_game()
	#else:
		#game.new_game()
