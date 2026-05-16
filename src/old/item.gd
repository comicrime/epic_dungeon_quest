class_name Item
extends Node2D

@export var properties: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(properties, "[Item][Ready] properties are null!")

func _process(delta):
	pass
