# Message Bus script. 
extends Node

# System events 
signal game_pause(state: bool)
signal zoom(dir: int)
signal game_requested(try_load: bool)
signal ui_press(ui_id: String)

# World events
signal level_initialized(level: Node)
signal map_data_update(md: MapData)
signal game_win

# Player events 
signal player_hp_change(new_hp: int)
signal player_level_transition(level: int)
signal player_died
signal kill_inc(inc: int)
