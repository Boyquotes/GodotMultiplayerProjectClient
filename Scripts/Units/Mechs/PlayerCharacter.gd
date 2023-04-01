extends CharacterBody3D

# exports
@export var nav_agent : NavigationAgent3D
@export var state_machine : StateMachine
@export var PlayerHealthBar : Node

# signals
signal walk_signal
signal walkto_signal
signal idle_signal

signal health_changed
signal max_health_changed
signal health_regen_changed

signal mana_changed
signal max_mana_changed
signal mana_regen_changed


signal xp_changed
signal max_xp_changed
signal leveled_up

signal stat_changed


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# character specific (probably use resource)
@onready var team : String = get_parent().team

# level

@onready var level = 1 :
	set(value):
		level = value
		emit_signal("stat_changed", "level", value)

# TODO start with all skills available or not?
var skillpoints = 1

@onready var xp : int = 0 :
	set(value):
		xp = value
		if level < Glob.MAX_LEVEL and xp > max_xp:
			var xp_overflow = max_xp - xp
			_on_level_up()
			emit_signal("leveled_up", level)
			xp = xp_overflow
		else:
			emit_signal("xp_changed", value)

@onready var max_xp = 1000 :
	set(value):
		max_xp = value
		emit_signal("max_xp_changed", value)


# stats
@onready var speed : int = 5 :
	set(value):
		speed = value
		emit_signal("stat_changed", "speed", value)


@onready var attack_range : int = 10 :
	set(value):
		attack_range = value
		emit_signal("stat_changed", "attack_range", value)
		
var attack_range_growth : int = 0

# setget change attack timers
@onready var attack_speed : float = 2 :
	set(value):
		attack_speed = value
		emit_signal("stat_changed", "attack_speed", value)
		
var attack_speed_growth : float = 0

# TODO change attack windup process
var attack_windup : float = 0.6
var attack_cooldown : float = 1.4

@onready var max_hp : int = 1000 :
	set(value):
		max_hp = value
		emit_signal("max_health_changed", value)

@onready var hp : int = max_hp :
	set(value):
		hp = value
		emit_signal("health_changed", value)
		if hp < 0:
			transform.origin = Vector3(0, -10, 0)

@onready var hp_regen = 5 :
	set(value):
		hp_regen = value
		emit_signal("health_regen_changed", value)

var hp_growth = 100
var hp_regen_growth = 2.5 

@onready var max_mana : int = 1000 :
	set(value):
		max_hp = value
		emit_signal("max_mana_changed", value)

@onready var mana : int = max_mana :
	set(value):
		mana = value
		emit_signal("mana_changed", value)

@onready var mana_regen = 5 :
	set(value):
		mana_regen = value
		emit_signal("mana_regen_changed", value)
		
var mana_growth = 100
var mana_regen_growth = 2.5





# TODO create high latency sync state for things like certain ui values
# attack range etc. things that don't change frequently or are synced indirectly
# add missing sync states variables like level etc
var sync_state:
	get:
#		#print("get sync state")
		var buf = PackedByteArray()
		buf.resize(16)
		buf.encode_u16(0, speed)
		buf.encode_u16(2, attack_range)
		buf.encode_u16(4, max_hp)
		buf.encode_u16(6, hp)
		buf.encode_half(8, transform.origin.x)
		buf.encode_half(10, transform.origin.y)
		buf.encode_half(12, transform.origin.z)
		buf.encode_half(14, attack_speed)
		return buf



var ability_types_array : Array[Glob.ABILITY_TYPES] = [] # glob ability_types
var ability_array : Array = [] # resources
var ability_cooldowns : Array[float] = [] # float
var ability_windups : Array[float] = [] # float
var ability_ready : Array[bool] = []
var ability_level : Array[int] = []



@export var projectiles_container : Node
@export var ability_timer_container : Node


@export var cooldown_timer_scene : PackedScene
@export var windup_timer_scene : PackedScene

# privates
#var _walk : bool = false

# dynamic publics
var targeted_unit : CharacterBody3D


@onready var parent_node = get_parent()

func _ready():
#	#print(get_parent(), " team is ", team)
	
	# debug server mode
	if parent_node.name == "0":
		get_parent().character_node = self
		Network.player_controller.spawn_camera(transform.origin)
		GameState.emit_signal("connect_ui_bars", self)

	
	
	set_collision_layer_value(Glob.LAYER.PLAYERS_BLUE, true)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
#	xp += 10 * level
	
	
func set_destination(target_position : Vector3):
	if target_position == null:
#		$NavigationAgent3D.set_target_location(global_transform.origin)
#		#print('target position was null, stop walking')
#		_walk = false
#		state_machine.transition_to("Idle")
		emit_signal("idle_signal")
	else:
#		#print('updated path to target position: ', target_position)
		nav_agent.set_target_location(target_position)# + Vector3 (0,1,0))
#		state_machine.transition_to("Walk")
		emit_signal("walk_signal")
		

func attack_target(target_unit):
	targeted_unit = target_unit
	emit_signal("walkto_signal")


func fire_ability(msg):
#	#print(msg)
	var ability_num = msg["ability_num"]
	if not ability_ready[ability_num]:
#		#print("ability %s was not ready for %s" % [ability_num, self])
		return
		
	# direct ref?
	msg["projectile_parent"] = projectiles_container
	
	ability_ready[ability_num] = false
	
	# start ability timers
	ability_timer_container.get_node("cooldown_%s" % ability_num).start()	
	
	var _windup = ability_windups[ability_num]
	if _windup == 0:
		ability_array[ability_num].fire(msg)
	else:
		# TODO also enter player windup state (maybe depending on resource windup locked bool)
		var _windup_timer = ability_timer_container.get_node("windup_%s" % ability_num)
		_windup_timer.msg = msg
		_windup_timer.start()
		
func windup_timer_timeout(ability_num, msg):
	# msg might be empty
	ability_array[ability_num].fire(msg)

func cooldown_timer_timeout(ability_num):
	ability_ready[ability_num] = true

func hit(damage):
	hp -= damage


func load_from_resource(resource_file : BaseCharacter):
	if resource_file:
		load_base_stats(resource_file)
		load_abilities(resource_file)
	else:
		# standard capsule stuff
		var player_mesh : MeshInstance3D = $PlayerMesh3D
		var newMaterial = StandardMaterial3D.new() #Make a new Spatial Material
#		#print(parent_node)
		newMaterial.albedo_color = parent_node.team_color
		player_mesh.material_override = newMaterial #Assign new material to material overrride


func load_base_stats(resource_file : BaseCharacter):
	max_hp = resource_file.hp
	hp = resource_file.hp
	hp_growth = resource_file.hp_growth
	hp_regen = resource_file.hp_regen
	hp_regen_growth = resource_file.hp_regen_growth
	
	max_mana = resource_file.mana
	mana = resource_file.mana
	mana_growth = resource_file.mana_growth
	mana_regen = resource_file.mana_regen
	mana_regen_growth = resource_file.mana_regen_growth
	
	attack_range = resource_file.attack_range
	attack_range_growth = resource_file.attack_range_growth
	attack_speed = resource_file.attack_speed
	attack_speed_growth = resource_file.attack_speed_growth
	attack_windup = resource_file.attack_windup


func load_abilities(resource_file : BaseCharacter):
	var array_of_abilities : Array[BaseAbility] = resource_file.ability_resource_array
	var ability_num : int = 0
	for ability_resource in array_of_abilities:
		ability_types_array.append(ability_resource.ability_type)
		ability_array.append(ability_resource)
		
		# ability useable and cooldown/windup
		ability_ready.append(false)
		ability_level.append(0)
		
		var cooldown_timer = cooldown_timer_scene.instantiate()
		ability_timer_container.add_child(cooldown_timer)
		cooldown_timer.name = "cooldown_" + str(ability_num)
		cooldown_timer.player_character = self
		cooldown_timer.ability_num = ability_num
		
		
		var windup_timer = windup_timer_scene.instantiate()
		windup_timer.name = "windup_" + str(ability_num)
		ability_timer_container.add_child(windup_timer)
		
		# ability ui stuff TODO maybe not send entire resource?
		GameState.emit_signal("add_ui_ability", ability_resource, ability_num, cooldown_timer)
		
		
		# could also read from resource instead
		ability_cooldowns.append(float(0))
		ability_windups.append(float(0))
		
		# FOR DEBUGGING PURPOSES, IMPLEMENT LEVEL UP
		ability_levelup(ability_num)
		
		ability_num += 1
		


func _on_level_up():
	level += 1
	hp += hp_growth
	hp_regen += hp_regen_growth
	mana += mana_growth
	mana_regen += mana_regen_growth
	
	attack_speed += attack_speed_growth
	
	
	# TODO implement xp curve
	max_xp += 100
	

func ability_levelup(ability_num):
	# first check
	var ability_resource : BaseAbility = ability_array[ability_num]
	if ability_level[ability_num] > ability_resource.max_level:
#		#print("tried to level up ability above max level! ", ability_num, self)
		return
	
	# increase level
	ability_level[ability_num] += 1
	var current_ability_level = ability_level[ability_num]
	
	# available if level 1
	if current_ability_level >= 1:
		ability_ready[ability_num] = true
	
	# leveling up
	###############################
	
	var ability_cooldown = ability_resource.cooldown_array[current_ability_level + 1]
	ability_cooldowns[ability_num] = ability_cooldown
	
	var msg = {"cooldown" : ability_cooldown}
	GameState.emit_signal("leveled_up_ability", ability_num, msg)

	# TODO update ability damage etc.
