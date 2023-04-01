extends State

var nav_agent : NavigationAgent3D
var parent_unit : BaseUnit

var movement_delta : float




func _ready():
	await get_parent().ready
	get_parent().navigation_agent.connect("velocity_computed", _on_NavigationAgent3D_velocity_computed)


# Walk enter and exit states should probably stay empty
# as players click multiple times when walking
func enter(_msg := {}) -> void:
#	#print(parent_unit, " aaaaaaaaaaaaaaaaaa")
#	#print("Entering state: ", name)
	var target_position = _msg["target_position"]
	nav_agent.target_position = target_position
#	parent_unit.look_at(target_position)
#	state_machine.animation_player.play("Run")
#	#print("Walking to ", nav_agent.get_next_location())
#	#print("Currently at ", parent_unit.global_transform.origin)


func physics_update(_delta: float) -> void:
	var walk_target = nav_agent.get_next_path_position()
	
	# code for look direction
#		if last_look_target != walk_target:
##			#print('still turning ', look_target, walk_target)
#			look_target = walk_target
	
#	var direction : Vector3 = walk_target - parent_unit.global_transform.origin
##	#print("direction:", direction)
#	parent_unit.set_velocity(direction.normalized() * parent_unit.speed) # TODO this is 0?
##		#print(walk_target, global_transform.origin)
##	#print("direction:", parent_unit, parent_unit.speed)
#	parent_unit.move_and_slide()
	
	movement_delta = _delta * parent_unit.speed
	var direction : Vector3 = walk_target - parent_unit.global_transform.origin
	var velocity : Vector3 = direction.normalized() * movement_delta
	
	if velocity.length() > 0.03:
		parent_unit.look_at(walk_target)
#	#print("velocity in:", velocity)
	state_machine.navigation_agent.set_velocity(velocity)
	
	
	
	if nav_agent.is_navigation_finished():
#		#print('arrived!')
		state_machine.transition_to("Idle", {"arrived" : true})
#	else:
#		#print("walking to %s, currently at %s" % [nav_agent.get_next_location(), parent_unit.global_transform.origin])
#	move_and_slide()


func _on_NavigationAgent3D_velocity_computed(safe_velocity : Vector3):
	# Move Node3D with the computed `safe_velocity` to avoid dynamic obstacles.
	if state_machine.state == self:
#		safe_velocity = safe_velocity.normalized()
		parent_unit.global_transform.origin = parent_unit.global_transform.origin.move_toward(parent_unit.global_transform.origin + safe_velocity, movement_delta)
		
		if safe_velocity.length() > 0.03:
			parent_unit.look_at(parent_unit.global_transform.origin + safe_velocity)
