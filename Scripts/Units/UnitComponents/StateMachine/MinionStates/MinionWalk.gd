extends State

# assigned by nav agent
var nav_agent : NavigationAgent3D
var parent_unit : BaseUnit

#var update_timer : Timer = Timer.new()

var path_follow : PathFollow3D

var ratio_sample_interval = 0.1

var path_offset : Vector3
var current_progress : float = 0.1
var current_destination : Vector3

var destination
var walk_target

var movement_delta : float

signal walk_target_initiated

@onready var WaypointFlagScene = preload("res://Assets/Objects/Navigation/WaypointFlag.tscn")
var waypoint_flag

func _ready():
	var unit = get_parent().get_parent()
	unit.connect("lane_follow_changed", update_lane_follow)
	update_lane_follow(get_parent().get_parent().lane_follow)
	
	get_parent().navigation_agent.connect("velocity_computed", _on_NavigationAgent3D_velocity_computed)
#	update_timer = Timer.new()
#	update_timer.wait_time = 0.5
	
#	#print(unit.team)
#	if unit.team == "Red":
#		current_progress = 1
#		ratio_sample_interval = -ratio_sample_interval
#		#print("new ratio", ratio_sample_interval)
	
	

func enter(_msg := {}) -> void:
	# get next navigation target if arrived
#	if _msg.has("arrived") and _msg["arrived"]:

	# TODO change this to best next location using get_closest_point_on_lane_follow
	if current_progress > 1:
		current_progress = 1
	destination = get_position_on_path(current_progress)
	nav_agent.target_position = destination
#	update_timer.start()
#	#print("walking to ", current_destination, " with lane curve points: ", get_parent().get_parent().get_parent().curve.get_baked_points())
	
	if GameState.debug_pathing:
		waypoint_flag = WaypointFlagScene.instantiate()
		waypoint_flag.get_node("Timer").queue_free()
		add_child(waypoint_flag)
		waypoint_flag.global_transform.origin = destination
	# walk
#	state_machine.transition_to("Walk", {"target_position" : current_destination})

	# attack unit

func exit(_msg := {}) -> void:
	if GameState.debug_pathing:
		waypoint_flag.queue_free()


func physics_update(_delta: float) -> void:
	walk_target = nav_agent.get_next_path_position()
	
	if GameState.debug_pathing:
		waypoint_flag.global_transform.origin = walk_target
	
	if nav_agent.is_navigation_finished():
		current_progress += ratio_sample_interval
		state_machine.transition_to("Idle", {"arrived" : true})

	
#	parent_unit.look_at(walk_target)
	
	# code for look direction
#		if last_look_target != walk_target:
##			#print('still turning ', look_target, walk_target)
#			look_target = walk_target
	movement_delta = _delta * parent_unit.speed
	var direction : Vector3 = walk_target - parent_unit.global_transform.origin
	var velocity : Vector3 = direction.normalized() * movement_delta
#	#print("velocity in:", velocity)
	state_machine.navigation_agent.set_velocity(velocity)
#	parent_unit.set_velocity(velocity)
	
#	state_machine.navigation_agent.set_velocity(velocity)
#		#print(walk_target, global_transform.origin)
#	#print("direction:", parent_unit, parent_unit.speed)
#	parent_unit.move_and_slide()
	



func get_position_on_path(progress : float):
#	path_follow.progress_ratio = progress - 0.5
	var start_transform = path_follow.transform.origin
	path_follow.progress_ratio = progress
	
	var pos_offset = (path_follow.transform.origin-start_transform).normalized().rotated(Vector3.UP, 90) * path_offset.x * 3
#	#print(pos_offset)
	return path_follow.transform.origin + pos_offset

func update_lane_follow(lane_follow):
#	#print("using lane follow: ", lane_follow)
	path_follow = lane_follow
	current_progress = ratio_sample_interval
	current_destination = get_position_on_path(current_progress)


func _on_NavigationAgent3D_velocity_computed(safe_velocity : Vector3):
	# Move Node3D with the computed `safe_velocity` to avoid dynamic obstacles.
	if state_machine.state == self:
#		safe_velocity = safe_velocity.normalized()
		parent_unit.global_transform.origin = parent_unit.global_transform.origin.move_toward(parent_unit.global_transform.origin + safe_velocity, movement_delta)
		
		if safe_velocity.length() > 0.03:
			parent_unit.look_at(parent_unit.global_transform.origin + safe_velocity)
#		#print("velocity out:", safe_velocity)
#func get_closest_point_on_lane_follow or something



# TODO periodically update nav agent path
#func _on_update_timer_timeout():
	
