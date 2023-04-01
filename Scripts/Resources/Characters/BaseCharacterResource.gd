extends Resource
class_name BaseCharacter

@export var hp : int
@export var hp_growth : int
@export var hp_regen : int
@export var hp_regen_growth : int

@export var mana : int
@export var mana_growth : int
@export var mana_regen : int
@export var mana_regen_growth : int


@export var attack_range : int
@export var attack_range_growth : int

@export var attack_speed : float
@export var attack_speed_growth : float
@export var attack_windup : float

@export var speed : int
@export var radius : float

# model + animation resources
# player mesh path
# animations

# ability resources
@export var ability_resource_array : Array[BaseAbility]





