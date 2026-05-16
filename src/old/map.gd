extends Node2D

var player: Resource = preload("res://scenes/old/player.tscn")

var levels: Dictionary[int, Resource] = {
	0: preload("res://scenes/old/surface.tscn")
}

var current_level: Node2D 


func _init():
	print("[map] init")

func _ready():
	MsgBus.player_level_transition.connect(_on_player_level_transition)
	print("[map] ready")

func _enter_tree():
	print("[map] enter tree")

func load_level(level_number: int) -> void: 
	var level_scene: Resource = self.levels[level_number]
	if level_scene == null:
		print_debug("[load_level] invalid level_number ", level_number)
		get_tree().quit()

	var level = level_scene.instantiate()
	print("[load_level] level: ", level)
	add_child(level)
	
	var player_instance = player.instantiate() as CharacterBody2D
	player_instance.position =  Vector2(1, 1)
	add_child(player_instance)
	
func _on_player_level_transition(level: int) -> void:
	print("netx level: ", level)
	pass
