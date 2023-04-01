# Idle.gd
extends PlayerState

@export var nav_agent : NavigationAgent3D


# Walk enter and exit states should probably stay empty
# as players click multiple times when walking
#func enter(_msg := {}) -> void:
#	#print("Entering state: WalkingToTarget")


func physics_update(delta: float) -> void:
	var walk_target = nav_agent.get_next_location()
	
	# code for look direction
#		if last_look_target != walk_target:
##			#print('still turning ', look_target, walk_target)
#			look_target = walk_target
	
	var direction: Vector3 = walk_target - owner.global_transform.origin
	owner.set_velocity(direction.normalized() * owner.speed)
#		#print(walk_target, global_transform.origin)
	owner.move_and_slide()
	
	if nav_agent.is_navigation_finished():
#		#print('arrived!')
		state_machine.transition_to("Idle")
#	move_and_slide()

