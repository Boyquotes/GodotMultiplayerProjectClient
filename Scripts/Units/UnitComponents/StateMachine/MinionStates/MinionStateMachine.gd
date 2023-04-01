# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name MinionStateMachine
extends StateMachine



# TODO somehow sync state without syncing entire node

#@export var unit_area : Area3D
##@export var navigation_agent : NavigationAgent3D
#
#
##func _ready() -> void:
##	super._ready()
##
##	unit_area.connect("body_entered", _body_entered)
#
## The state machine subscribes to node callbacks and delegates them to the state objects.
#func _unhandled_input(event: InputEvent) -> void:
#	state.handle_input(event)
#
#
#func _process(delta: float) -> void:
#	state.update(delta)


#func _physics_process(delta: float) -> void:
#	state.physics_update(delta)
#
#func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
#	super.transition_to(target_state_name, msg)
		

#func _body_entered(body : Node3D):
#	# save team in statemachine to make it faster?
#	if state.name == "Walk" and body is BaseUnit and body.team != get_parent().team:
##		#print("Enemy body entered area! ", body)
#		transition_to("Idle", {})
