class_name UnitExperienceComponent
extends UnitComponent

signal leveled_up
signal xp_changed
signal max_xp_changed


var level

# TODO start with all skills available or not?
var skillpoints : int

@onready var xp : int
@onready var max_xp : int

func _ready():
	super._ready()
#	get_parent().connect("level_changed", update_level)
#	get_parent().connect("resource_loaded", load_from_resource)

#func update_level(value):
#	level = value

func load_from_resource(_resource_file : BaseCharacter):
	level = 1
	skillpoints = 1
	xp = 0
	max_xp = 1000
