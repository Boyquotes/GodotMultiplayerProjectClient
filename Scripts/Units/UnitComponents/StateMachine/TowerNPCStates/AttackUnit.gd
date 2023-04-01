

# Idle.gd
extends State

@export var cooldown_timer : Timer
@export var windup_timer : Timer
@export var winddown_timer : Timer



var parent_unit
var target_unit

var aim_line : CSGCylinder3D
var aim_start : Node3D
var start_transform


@export var _windup_done : bool = false
@export var _can_attack : bool = true


func _ready():
	parent_unit = get_parent().get_parent()
	
	await get_parent().ready
	start_transform = aim_line.transform.origin

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
#	#print("Entering state: ", name)
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
#	#print("Entering state: AttackCooldown")
	
#	if _msg["target_unit"] != target_unit:
	
	
	target_unit = _msg["target_unit"]
#	turret_aim()
#	target_unit.connect("unit_died", _on_target_died)
	
#	if _can_attack:
#		state_machine.transition_to("AttackWindup")
#	else:
#		cooldown_timer.start(owner.attack_cooldown)

func exit(_msg := {}) -> void:
#	if is_instance_valid(target_unit):
#		target_unit.disconnect("unit_died", _on_target_died)

#	stop_turret_aim()
	aim_line.transform.origin = start_transform
	cooldown_timer.stop()

# maybe slightly less often updating?
func physics_update(delta: float) -> void:
	# Potential bug: might not work if unit respawns too quickly (maybe check if target is within aggression range?)
	if not is_instance_valid(target_unit) or target_unit.state_machine.unit_status == Glob.status.DEAD or state_machine.state != self:
#		#print("target_unit lost")
		state_machine.transition_to("Idle")
	# unit walked out of range
	var target_transform = target_unit.global_transform.origin
	
#	#print(parent_unit.transform.origin.distance_to(target_transform))
	if parent_unit.transform.origin.distance_to(target_transform) > parent_unit.attack_range:
		state_machine.transition_to("Idle", {})
	
	# aim line stuff
	aim_line.transform.origin = aim_start.transform.origin #(target_transform + aim_start.transform.origin) / 2
	aim_line.height = aim_start.global_transform.origin.distance_to(target_transform) * 2
#	aim_line.global_rotate(Vector3(1,0,0), aim_start.global_transform.origin.angle_to(target_transform))

#	aim_line.rotation = aim_start.transform.origin.angle_to(target_transform)
	
#	#print("target: ", target_unit.global_transform.origin, " self: ", aim_line.global_transform.origin)
	aim_line.look_at(target_unit.transform.origin - aim_start.transform.origin)
	aim_line.rotate_y(PI)
	
	
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
		
	

#func _on_target_died():
#	state_machine.transition_to("Idle", {})

func _on_attack_windup_timeout():
	_windup_done = true
	winddown_timer.start()


func _on_attack_cooldown_timeout():
	_can_attack = true


func _on_attack_winddown_timeout():
	# winddown animation?
	_windup_done = false
