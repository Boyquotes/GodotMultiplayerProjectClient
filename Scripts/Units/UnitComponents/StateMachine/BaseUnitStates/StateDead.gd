extends State








## Upon entering the state, we set the Player node's velocity to zero.
#func enter(_msg := {}) -> void:
#	# We must declare all the properties we access through `owner` in the `Player.gd` script.
##	owner.velocity = Vector2.ZERO
##	state_machine.animation_player.play("Idle")
##	#print("Entering state: ", name)
#	state_machine.unit_status = Glob.status.DEAD
#
#	#death animation
##	await get_tree().create_timer(3).timeout
#
#func physics_process(_msg := {}) -> void:
#	if state_machine.unit_status != Glob.status.DEAD:
#		# TODO change target state to respawn state for animation?
#		state_machine.transition_to("Idle", {})
#
#
## Virtual function. Called by the state machine before changing the active state. Use this function
## to clean up the state.
#func exit() -> void:
#	pass




