# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = get_node(initial_state)


@export var network_state_name : String :
	set(state_name):
#		#print("received network state ", state_name, " for ", self)
		transition_to(state_name)
		network_state_name = state_name

# TODO somehow sync state without syncing entire node

#func _ready() -> void:
#	# not sure if this works correctly
#	var unit_node = get_parent()
##	#print("statemachine loaded")
#	await unit_node.ready
#	unit_node.state_machine = self
#	network_state_name = "Idle"
#	#print("Owner state machine: ", unit_node, unit_node.state_machine)
#
##	get_parent().connect("unit_died", _on_died)
#
#	# The state machine assigns itself to the State objects' state_machine property.
#	for child in get_children():
#		child.state_machine = self
#	state.enter()
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
#
# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	if state:
		state.exit()
		
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
#
#
#
##func _on_died():
#	self.transition_to("Dead", {})
