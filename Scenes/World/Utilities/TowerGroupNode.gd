extends Node3D

@export var team : String

#@onready var tower_scene = preload("res://Scenes/Units/NPCs/TowerNPC.tscn")
#@export var nexus_pos : Vector3
#
##var towers2 : PackedVector3Array = [Vector3(-25, -0.5, -40), Vector3(7.5, 0.5, -4.5)]
##var blue_towers : PackedVector3Array = [Vector3(25, 0.5, 40), Vector3(-7.5, -0.5, 4.5)]
#
#
#
#
#func _ready():
#	var i = 0
#	for tower in towers:
#		spawn_tower(tower, i)
#		i += 1




#func spawn_tower(position, i):
#	#TODO turn turret away from ally nexus
#
#	var tower_node = tower_scene.instantiate()
#
#	tower_node.team = team
#	tower_node.spawn_location = position
#
#	tower_node.load_from_resource()
#
#	add_child(tower_node, true)
#	tower_node.spawn_unit()
#	tower_node.look_at(tower_node.transform.origin - nexus_pos)
