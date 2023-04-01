extends State

var nav_agent : NavigationAgent3D
var parent_unit : BaseUnit
var target_unit : BaseUnit

@onready var update_path_timer : Timer


var movement_delta : float

func _ready():
	# TODO update more often
	update_path_timer = Timer.new()
	update_path_timer.one_shot = false
	add_child(update_path_timer)
#	update_path_timer.connect("timeout", _on_update_path_timer_timeout)
	get_parent().navigation_agent.connect("velocity_computed", _on_NavigationAgent3D_velocity_computed)

# Walk enter and exit states should probably stay empty
# as players click multiple times when walking
func enter(_msg := {}) -> void:
#	#print("Entering state: ", name)
	target_unit = _msg["target_unit"]
#	target_unit.connect("unit_died", _on_target_died)
	nav_agent.set_target_location(target_unit.transform.origin)
	

#func _on_target_died():
#	#print("target died")
#	state_machine.transition_to("Idle", {})

func exit(_msg := {}) -> void:
#	if is_instance_valid(target_unit):
#		target_unit.disconnect("unit_died", _on_target_died)
	update_path_timer.stop()


func physics_update(_delta: float) -> void:
	# target lost
	if not is_instance_valid(target_unit) or target_unit.state_machine.unit_status == Glob.status.DEAD:
#		#print("target_unit lost")
		state_machine.transition_to("Idle")
		
	# in attack range
	if parent_unit.transform.origin.distance_to(target_unit.transform.origin) <= parent_unit.attack_range:
		state_machine.transition_to("AttackUnit", {"target_unit" : target_unit})
		
	# walk to unit
	else:
		var walk_target = nav_agent.get_next_location()
#		get_node("../Walk").waypoint_flag.global_transform.origin = walk_target
#		#print("walk target is ", walk_target)
		# code for look direction
	#		if last_look_target != walk_target:
	##			#print('still turning ', look_target, walk_target)
	#			look_target = walk_target
		
		movement_delta = _delta * parent_unit.speed
		var direction : Vector3 = walk_target - parent_unit.global_transform.origin
		var velocity : Vector3 = direction.normalized() * movement_delta
#		#print("walking to: %s with velocity: %s" % [walk_target, velocity])
#		parent_unit.set_velocity(direction.normalized() * parent_unit.speed)
	#		#print(walk_target, global_transform.origin)
#		parent_unit.move_and_slide()
		state_machine.navigation_agent.set_velocity(velocity)
		
		# this should never happen realistically
		# maybe if target dies while walking to them?
		if nav_agent.is_navigation_finished():
#			#print('arrived at WalkToTarget location??????')
			state_machine.transition_to("Idle")

func _on_NavigationAgent3D_velocity_computed(safe_velocity : Vector3):
	# Move Node3D with the computed `safe_velocity` to avoid dynamic obstacles.
#	parent_unit.global_transform.origin = parent_unit.global_transform.origin.move_toward(parent_unit.global_transform.origin + safe_velocity, movement_delta)
	if state_machine.state == self:
#		#print(safe_velocity, movement_delta)
		parent_unit.global_transform.origin = parent_unit.global_transform.origin.move_toward(parent_unit.global_transform.origin + safe_velocity, movement_delta)
#		parent_unit.velocity = safe_velocity
		if safe_velocity.length() > 0.03:
			parent_unit.look_at(parent_unit.global_transform.origin + safe_velocity)

func _on_update_path_timer_timeout():
	nav_agent.set_target_location(target_unit.transform.origin)
