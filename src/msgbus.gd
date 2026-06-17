# Message Bus script. 
extends Node

# System events 
signal game_pause(state: bool)
signal zoom(dir: int)
signal game_requested(try_load: bool)
signal options_requested(try_load: bool)
signal main_menu_requested()
signal exit_requested()
signal sound_event(ui_id: String)
signal message_sent(text: String, color: Color)
signal player_init(player: Entity)

# World events
signal level_initialized(level: Node)
signal map_data_update(md: MapData)
signal game_win
signal item_pickup_confirm(item: Item)

# Player events 
signal player_hp_change(new_hp: int)
signal player_level_transition(level: int)
signal player_died
signal kill_inc(inc: int)
signal dwell(player: Entity)

signal item_pickup(item: Item, entity: Entity) 
signal item_used(item: Item, entity: Entity) 
signal item_update(item: Item, entity: Entity)
