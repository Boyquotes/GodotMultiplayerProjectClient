# This node exists for each player server as well 
# as all clients and therefor shouldn't handle input etc

extends Node

var player_name : String

# slot in team
var player_slot : int
@export var position : Vector3
@export var character_node : CharacterBody3D
#var sync_state:
#	get:
#		var buf = PackedByteArray()
#		buf.resize(6)
#		buf.encode_half(0, position.x)
#		buf.encode_half(2, position.y)
##		buf.encode_u8(4, health)
##		buf.encode_u8(5, mana)
#		return buf
#
#	set(value):
##		assert(typeof(value) == TYPE_RAW_ARRAY and value.size() == 6, "Invalid `sync_state` array type or size (must be TYPE_RAW_ARRAY of size 6).")
#		position = Vector3(value.decode_half(0), 0, value.decode_half(2))
##		health = value.decode_u8(4)
##		mana = value.decode_u8(5)
		




# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player Created. Name: %s" % player_name)

	# should be done on game start instead of player joining
#	print("loading player model")
#	var player_character = preload("res://Scenes/Player/PlayerCharacter.tscn")
#	var player_character_instance = player_character.instantiate()
#	player_character_instance.transform.origin = Vector3(randf_range(-9,9), 1.5, randf_range(-9,9))
#	add_child(player_character_instance)
#	print("Instantiated Player %s at position " % player_name, player_character_instance.transform.origin)

	# pass stuff to playercontroller
	if self.name == str(Network.multiplayer.get_unique_id()):
		get_parent().my_player_node = self
		print(get_parent(), " was assigned: ", self)

	else:
		print("aaaaa", get_parent().name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func physics_process(delta):
#	pass

#func spawn_player_character(slot):
#	print("loading player model")
#	var player_character = preload("res://Scenes/Player/PlayerCharacter.tscn")
#	character_node = player_character.instantiate()
#	character_node.transform.origin = Vector3(2*slot, 1.5, 2*slot)
#	add_child(character_node)
#	print("Instantiated Player %s at position " % player_name, character_node.transform.origin)


func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		print("Player deleted. Name: %s" % player_name)



