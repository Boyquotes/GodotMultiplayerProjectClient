# Idle.gd
extends State

@export var windup_timer : Timer
@export var aa_node : Node
@onready var aa_bullet = preload("res://Scenes/Projectiles/PlaceHolderAutoAttack.tscn")

var target
#var _can_attack = true

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: AttackWindup")
	
#	if not state_machine.can_attack:
#		state_machine.transition_to("AttackCooldown")
#	else:
	target = owner.targeted_unit
	windup_timer.start(owner.attack_windup)

func exit(_msg := {}) -> void:
	windup_timer.stop()

func update(delta: float) -> void:
	# animation or something
	if owner.transform.origin.distance_to(target.transform.origin) > owner.attack_range:
		state_machine.transition_to("WalkToTarget")


func _on_attack_windup_timer_timeout():
	# do attack (spawn etc), add damage to bullet
#	#print("attacked!")
	var instanced_bullet = aa_bullet.instantiate()
	instanced_bullet.transform.origin = owner.transform.origin + Vector3(0, 0.5, 0)
	instanced_bullet.target = target
	instanced_bullet.attack_owner = owner
	aa_node.add_child(instanced_bullet, true)
	
	state_machine.transition_to("AttackCooldown")
