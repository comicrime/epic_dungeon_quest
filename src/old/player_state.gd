extends Node

@onready var hp: int = 100 #replace for save data
@onready var mp: int = 100 #replace for save data
@onready var status_effects: Dictionary =  {
	"test": 1
}

@onready var inventory: Array[Item] = []

var current_level: int = 0

func _ready():
	MsgBus.player_hp_change.connect(self._on_hp_change)
	MsgBus.player_level_transition.connect(self._on_level_transition)

func _process(delta):
	pass

func _on_hp_change(new_hp: int) -> void:
	print("[HP_CHANGE] new hp: ", new_hp)
	self.hp = new_hp 
	
func _on_level_transition(level: int) -> void:
	print("[playerstate] level transition. current: ", current_level, " new level: ", level)
	self.current_level = level
