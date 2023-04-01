# Idle.gd
extends PlayerState

@export var nav_agent : NavigationAgent3D
@export var update_path_timer : Timer

var target



# Walk enter and exit states should probably stay empty
# as players click multiple times when walking
func enter(_msg := {}) -> void:
#	#print("Entering state: WalkingToTarget")
	target = owner.targeted_unit
	nav_agent.set_target_location(target.transform.origin)
	update_path_timer.start()
	
func exit(_msg := {}) -> void:
	update_path_timer.stop()


func physics_update(delta: float) -> void:
	if not target:
		state_machine.transition_to("Idle")
	if owner.transform.origin.distance_to(target.transform.origin) <= owner.attack_range:
		state_machine.transition_to("AttackCooldown")
	else:
		var walk_target = nav_agent.get_next_location()
		
		# code for look direction
	#		if last_look_target != walk_target:
	##			#print('still turning ', look_target, walk_target)
	#			look_target = walk_target
		
		var direction: Vector3 = walk_target - owner.global_transform.origin
		owner.set_velocity(direction.normalized() * owner.speed)
	#		#print(walk_target, global_transform.origin)
		owner.move_and_slide()
		
		# this should never happen realistically
		# maybe if target dies while walking to them?
		if nav_agent.is_navigation_finished():
#			#print('arrived at WalkToTarget location??')
			state_machine.transition_to("Idle")


func _on_update_path_timer_timeout():
	nav_agent.set_target_location(target.transform.origin)
