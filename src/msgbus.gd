# Message Bus script. 
extends Node

# System events 
signal game_pause(state: bool)

# World events
signal level_initialized(level: Node)

# Player events 
signal player_hp_change(new_hp: int)
signal player_pickable_cb(pickable: PickableComponent)
signal player_level_transition(level: int)
signal player_died
