extends State

@export var stunned_timer : Timer


# TODO test and probably fix

func _ready():
	allow_transitions = false

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: ", name)
	stunned_timer.start(_msg["stunned_time"])
#	await stunned_timer.timeout


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


