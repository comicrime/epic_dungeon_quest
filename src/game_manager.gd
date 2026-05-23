extends Node

const game_scene: PackedScene = preload("res://scenes/dungeon_game.tscn")
const main_menu_scene: PackedScene = preload("res://scenes/main_menu_ui.tscn")
const win_screen: PackedScene = preload("res://scenes/win_screen.tscn")

const main_menu_music = preload("res://assets/music/sewers_tense.ogg")
const in_game_music = preload("res://assets/music/game.mp3")
const win_music = preload("res://assets/music/main + dora - 140 am @mask_line11.wav")

var current_child: Node

func _ready():
	MsgBus.game_win.connect(_on_win)
	%BGMusicPlayer.stop()
	%BGMusicPlayer.stream = main_menu_music
	%BGMusicPlayer.play()
	load_main_menu()

func load_main_menu() -> void:
	switch_to_scene(main_menu_scene)
	MsgBus.game_requested.connect(_on_game_requested)

func switch_to_scene(scene: PackedScene) -> Node:
	if current_child != null:
		current_child.visible = false
		current_child.queue_free()
	
	current_child = scene.instantiate()
	add_child(current_child)
	return current_child

func _on_game_requested(try_load: bool) -> void:
	%BGMusicPlayer.stop()
	%BGMusicPlayer.stream = in_game_music
	%BGMusicPlayer.play()
	switch_to_scene(game_scene)

func _on_win() -> void: 
	%BGMusicPlayer.stop()
	%BGMusicPlayer.stream = win_music
	%BGMusicPlayer.play()
	switch_to_scene(win_screen)
