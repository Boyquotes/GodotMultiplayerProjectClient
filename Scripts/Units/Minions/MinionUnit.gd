class_name MinionUnit
extends NPCUnit



#signal lane_follow_changed
#
#
#
#
#
#var lane_node : Path3D
#var lane_follow : PathFollow3D :
#	set(value):
#		lane_follow = value
#		emit_signal("lane_follow_changed", value)
#
#
#
#func _ready():
#	super._ready()
#	var col_node : CollisionShape3D = get_node("AggroArea3D").get_node("CollisionShape3D")
#	col_node.shape.radius = aggro_range



