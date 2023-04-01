class_name UnitComponent
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("resource_loaded", load_from_resource)


func load_from_resource(_resource_file : BaseCharacter):
	pass
