# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name NPCStateMachine
extends StateMachine



# TODO somehow sync state without syncing entire node

#@export var unit_area : Area3D
##@export var navigation_agent : NavigationAgent3D
#
#@export var aim_line : CSGCylinder3D
#@export var aim_start : Node3D


#func _ready() -> void:
#	super._ready()
#
#	var attack_state = get_node("AttackUnit")
#	attack_state.aim_line = aim_line
#	attack_state.aim_start = aim_start
##	unit_area.connect("body_entered", _body_entered)
#
## The state machine subscribes to node callbacks and delegates them to the state objects.
#func _unhandled_input(event: InputEvent) -> void:
#	state.handle_input(event)
#
#
#func _process(delta: float) -> void:
#	state.update(delta)
#
#
#func _physics_process(delta: float) -> void:
#	state.physics_update(delta)
#
#func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
#	super.transition_to(target_state_name, msg)
		

#func _body_entered(body : Node3D):
#	# save team in statemachine to make it faster?
#	if state.name == "Idle" and body is BaseUnit and body.team != get_parent().team:
##		#print("Enemy body entered area! ", body)
#		transition_to("Idle", {})
#	else:
#		#print(body, " is not an enemy ", body.team)
