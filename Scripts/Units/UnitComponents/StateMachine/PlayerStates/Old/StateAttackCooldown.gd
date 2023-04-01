# Idle.gd
extends State

@export var cooldown_timer : Timer


var target
var _can_attack = true

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: AttackCooldown")
	
	if _can_attack:
		state_machine.transition_to("AttackWindup")
	else:
		cooldown_timer.start(owner.attack_cooldown)

func exit(_msg := {}) -> void:
	cooldown_timer.stop()

# maybe slightly less often updating?
func update(delta: float) -> void:
	if owner.distance_to(target) > owner.attack_range:
		state_machine.transition_to("WalkToTarget")
	elif _can_attack:
		state_machine.transition_to("AttackWindup")


func _on_attack_cooldown_timer_timeout():
	_can_attack = true
