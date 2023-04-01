extends Resource

class_name BaseAbility

@export var ability_name : String
@export var ability_type : Glob.ABILITY_TYPES
@export var ability_description : String


@export var max_level : int# = 5
@export var damage_array : PackedInt64Array
@export var scaling_array : PackedFloat64Array
@export var range_array : PackedInt64Array

# array containing cooldowns at different ability levels
@export var cooldown_array : PackedFloat64Array
@export var windup_array : PackedFloat64Array


# textures and models
@export var ability_icon : CompressedTexture2D
@export var ability_scene : PackedScene

#func fire(msg):
#	#print(ability_name, " was fired with msg ", msg)
