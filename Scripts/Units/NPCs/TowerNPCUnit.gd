class_name TowerNPCUnit
extends NPCUnit



@export var aggresion_shape : CollisionShape3D



func _ready():
	super._ready()
#	#print("current hp: ", hp, self)
		
	var col_node : CollisionShape3D = get_node("AggroArea3D").get_node("CollisionShape3D")
	col_node.shape.radius = attack_range


#func _on_stat_change(stat_name, value):
#	super._on_stat_change(stat_name, value)
#
#	if stat_name == "attack_range":
#		aggresion_shape.shape.radius = value
