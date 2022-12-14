extends CharacterBody3D

signal health_changed
signal max_health_changed

var team : String
var speed : int = 5
var attack_range : int = 10


# setget change attack timers
var attack_speed : float = 2

@export @onready var max_hp : int = 1000 :
	set(value):
		max_hp = value
		emit_signal("max_health_changed", value)

@export @onready var current_hp : int = max_hp :
	set(value):
#		print("current_hp was changed: ", current_hp)
		current_hp = value
		emit_signal("health_changed", value)

var sync_state:
#	get:
#		print("get sync state")
#		var buf = PackedByteArray()
#		buf.resize(16)
#		buf.encode_u16(0, speed)
#		buf.encode_u16(2, attack_range)
#		buf.encode_u16(4, max_hp)
#		buf.encode_u16(6, current_hp)
#		buf.encode_half(8, transform.origin.x)
#		buf.encode_half(10, transform.origin.y)
#		buf.encode_half(12, transform.origin.z)
#		buf.encode_half(14, attack_speed)
#		return buf
	set(value):
		if value:
#			print("received sync state: ", value)
			speed = value.decode_u16(0)
			attack_range = value.decode_u16(2)
			max_hp = value.decode_u16(4)
			current_hp = value.decode_u16(6)
			transform.origin.x = value.decode_half(8)
			transform.origin.y = value.decode_half(10)
			transform.origin.z = value.decode_half(12)
			attack_speed = value.decode_half(14)
		
		




func _ready():
	var parent_node = get_parent()
	team = parent_node.team
	if parent_node.name == str(Network.multiplayer.get_unique_id()):
		get_parent().character_node = self
		Network.player_controller.spawn_camera(transform.origin)
		
	# fix collision layers and masks
	# (temp) change player color with team
	# potentially use setget instead of ready
	var player_mesh : MeshInstance3D = $PlayerMesh3D
	var newMaterial = StandardMaterial3D.new() #Make a new Spatial Material
	
	newMaterial.albedo_color = parent_node.team_color

	player_mesh.material_override = newMaterial #Assign new material to material overrride
