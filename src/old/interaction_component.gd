extends Node

@export var itypes: Array[InteractionTypes] 

enum InteractionTypes {
	UNKNOWN, 
	PICK,
	ACTIVATE
}

func pre_interact() -> void:
	pass 
	
func interact() -> void:  
	pass  
	
func post_interact() -> void:
	pass
