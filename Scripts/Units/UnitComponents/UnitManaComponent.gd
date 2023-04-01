class_name UnitManaComponent
extends UnitComponent

signal max_mana_changed
signal mana_changed
signal mana_regen_changed


@onready var max_mana : int

@onready var mana : int = max_mana

@onready var mana_regen
		
var mana_growth : int
var mana_regen_growth : float



func load_from_resource(resource_file : BaseCharacter):
	max_mana = resource_file.mana
	mana = resource_file.mana
	mana_growth = resource_file.mana_growth
	mana_regen = resource_file.mana_regen
	mana_regen_growth = resource_file.mana_regen_growth


