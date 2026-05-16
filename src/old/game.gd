extends Control

@onready var sfx_player: AudioStreamPlayer = %SFXPlayer
@onready var main_menu_ui = %MainMenuUI
@onready var pause_layer = %PauseLayer

var map = preload("res://scenes/old/map.tscn")
var surface = preload("res://scenes/old/surface.tscn")

func _ready() -> void:
	pause_layer.visible = false

func _process(_delta: float) -> void: 
	if Input.is_action_just_pressed("esc"):
		if main_menu_ui.visible: 
			get_tree().quit()
			return
			
		#pause_layer.visible = !pause_layer.visible

func _on_new_game_pressed():
	clear_ui()
	var map_instance = map.instantiate()
	add_child(map_instance)
	map_instance.load_level(0) 
	
func clear_ui() -> void:
	main_menu_ui.visible = false
	
func _on_options_pressed():
	print("[OPTIONS] unimplemented")

func _on_exit_pressed():
	print("[EXIT] exiting")
	get_tree().quit()
