class_name UnitHealthComponent
extends UnitComponent

@onready var max_hp : int :
	set(value):
		max_hp = value
		emit_signal("max_hp_changed", value)

@onready var hp : int = max_hp :
	set(value):
		hp = value
		emit_signal("hp_changed", value)

@onready var hp_regen :
	set(value):
		hp_regen = value
		emit_signal("hp_regen_changed", value)
		
var hp_growth : int
var hp_regen_growth : float


func load_from_resource(resource_file : BaseCharacter):
	max_hp = resource_file.hp
	hp = resource_file.hp
	hp_growth = resource_file.hp_growth
	hp_regen = resource_file.hp_regen
	hp_regen_growth = resource_file.hp_regen_growth


