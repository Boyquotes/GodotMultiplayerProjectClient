# Idle.gd
extends State

@export var cooldown_timer : Timer
@export var windup_timer : Timer
@export var winddown_timer : Timer



var parent_unit : BaseUnit
var target_unit : BaseUnit

@export var _windup_done : bool = false
@export var _can_attack : bool = true


func _ready():
	parent_unit = get_parent().get_parent()


# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
#	#print("Entering state: ", name)
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: AttackCooldown")
	
	target_unit = _msg["target_unit"]
#	target_unit.connect("unit_died", _on_target_died)
	
#	if _can_attack:
#		state_machine.transition_to("AttackWindup")
#	else:
#		cooldown_timer.start(owner.attack_cooldown)

func exit(_msg := {}) -> void:
#	target_unit.disconnect("unit_died", _on_target_died)
	cooldown_timer.stop()

# maybe slightly less often updating?
func physics_update(delta: float) -> void:
	if not is_instance_valid(target_unit) or target_unit.state_machine.unit_status == Glob.status.DEAD or state_machine.state != self:
#		#print("target_unit lost")
		state_machine.transition_to("Idle")
	# unit walked out of range
	var target_distance = parent_unit.transform.origin.distance_to(target_unit.transform.origin)
	if target_distance > parent_unit.attack_range:
		if target_distance > parent_unit.attack_range + parent_unit.aggro_range:
			state_machine.transition_to("Idle", {})
		else:
			state_machine.transition_to("TargetUnit", {"target_unit" : target_unit})
	
	# do attack stuff
	if not _windup_done and windup_timer.is_stopped():
		# TODO attack windup time
		# attack windup animation
		windup_timer.start()
	if not _can_attack and _windup_done and cooldown_timer.is_stopped():
		cooldown_timer.start()
	if _windup_done and _can_attack:
		_can_attack = false
		# attack animation
#		#print("do autoattack")
		parent_unit.auto_attack(target_unit)
		
		
		# TODO change timer when attack speed changed mid cooldown?
		cooldown_timer.start(1 / parent_unit.attack_speed)
	
		winddown_timer.start()
		
	

func _on_target_died():
	state_machine.transition_to("Idle", {})

func _on_attack_windup_timeout():
	_windup_done = true
	winddown_timer.start()


func _on_attack_cooldown_timeout():
	_can_attack = true


func _on_attack_winddown_timeout():
	# winddown animation?
	_windup_done = false
