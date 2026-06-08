class_name DataAccessLayer 
extends Node 

const saves_path = "user://saves/"

func save_map_data(sid: String, map_data: MapData) -> void: 
	var md_name: String = sid + str(Time.get_unix_time_from_system()) + str(map_data.level)
	
	
