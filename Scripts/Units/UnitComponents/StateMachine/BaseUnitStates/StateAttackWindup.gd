extends State

@export var windup_timer : Timer
@export var aa_node : Node
@onready var aa_bullet = preload("res://Scenes/Projectiles/PlaceHolderAutoAttack.tscn")
@onready var parent_unit : BaseUnit = state_machine.get_parent()


var target : BaseUnit

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: ", name)
	
	target = _msg["target"]
	windup_timer.start(_msg["attack_windup"])
	


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	windup_timer.stop()


func update(delta: float) -> void:
	# animation or something
	if parent_unit.transform.origin.distance_to(target.transform.origin) > parent_unit.attack_range:
		state_machine.transition_to("WalkToTarget")
		windup_timer.pause()
			
		
func change_target(new_target):
	target = new_target



func _on_attack_windup_timer_timeout():
	# do attack (spawn etc), add damage to bullet
#	#print("attacked!")
	var instanced_bullet = aa_bullet.instantiate()
	instanced_bullet.transform.origin = parent_unit.transform.origin + Vector3(0, 0.5, 0)
	instanced_bullet.target = target
	instanced_bullet.attack_owner = parent_unit
	aa_node.add_child(instanced_bullet, true)
	
	state_machine.transition_to("AttackCooldown")
