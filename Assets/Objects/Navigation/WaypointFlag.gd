extends Node3D


func _on_timer_timeout():
	get_parent().last_waypoint_flag = null
	queue_free()
