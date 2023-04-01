# BaseClass for all units
# Every unit needs these

class_name BaseUnit
extends CharacterBody3D



# Compositions
@export var state_machine : StateMachine

# Optional Compositions
@export var mana_component : UnitManaComponent
@export var experience_component : UnitExperienceComponent


@export var HealthBar : Node3D # visible healthbar ingame
@export var animation_manager : UnitComponentAnimationManager


#@onready var temp_nav_ref = navigation_agent

#@export var mp_sync : MultiplayerSynchronizer
@export var character_resource : BaseCharacter
@export var unit_scene : Node3D

# signals
signal health_changed
signal max_health_changed
signal health_regen_changed

signal level_changed

signal stat_changed

signal resource_loaded

signal unit_died

@onready var team : String = get_parent().team
@export var spawn_location : Vector3


var level
var speed : int
var attack_range : int
var attack_speed : float
var attack_speed_growth : float
var attack_windup : float
var attack_cooldown : float

var max_hp : int = 1 :
	set(value):
		if value != max_hp:
			max_hp = value
			emit_signal("max_health_changed", value)
			#print("max hp changed ", self, max_hp)
		
var hp : int = max_hp :
	set(value):
		if value != hp:
			hp = value
			emit_signal("health_changed", value)
	#		#print("health changed ", value, self)

var hp_growth : int
var hp_regen : float
var hp_regen_growth : float

@export var radius : float = 1


# TODO
var mp_sync :
	set(value):
		if value:
#			#print("received sync state: ", value)
			speed = value.decode_u16(0)
			attack_range = value.decode_u16(2)
			max_hp = value.decode_u16(4)
			hp = value.decode_u16(6)
			transform.origin.x = value.decode_half(8)
			transform.origin.y = value.decode_half(10)
			transform.origin.z = value.decode_half(12)
			attack_speed = value.decode_half(14)
			level = value.decode_half(16)

@onready var parent_node = get_parent()


#func _physics_process(delta):
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
	


#func _on_gamestate_tick():
#	if hp > 0 and hp < max_hp:
#		hp += hp_regen


func _ready():
	# remove later
#	#print(get_parent(), " team is ", team)
#	mp_sync.replication_config.add_property(NodePath(str(get_path()) + ":sync_state"))
	
	# debug server mode
	if parent_node.name == Network.get_player_node().name:
		get_parent().character_node = self
		Network.player_controller.spawn_camera(spawn_location)
		GameState.emit_signal("connect_ui_bars", self)

#	GameState.connect("game_ticked", _on_gamestate_tick)
	
	if unit_scene:
		connect("mouse_entered", _on_mouse_entered)
		connect("mouse_exited", _on_mouse_exited)
		unit_scene.set_script(load("res://Scripts/Units/UnitComponents/UnitSceneScript.gd"))
	


#func move_to_position(target_position : Vector3):
#	if nav_component:
#		nav_component.move_to_position(target_position)
#
#
#func move_to_target(target_unit : BaseUnit):
#	if nav_component:
#		nav_component.move_to_target(target_unit)


# base unit default auto attack
#func auto_attack(target_unit):
#	if attack_range > 3:
#		var aa_bullet = preload("res://Scenes/Projectiles/PlaceHolderAutoAttack.tscn")
#
#	#	#print("attacked!")
#		var instanced_bullet = aa_bullet.instantiate()
#
#		if $AutoAttackPosition:
#			instanced_bullet.transform.origin = $AutoAttackPosition.global_transform.origin
#		else:	
#			instanced_bullet.transform.origin = global_transform.origin
#
#		instanced_bullet.target = target_unit
#		instanced_bullet.attack_owner = self
#		GameState.world_node.add_child(instanced_bullet, true)
#	else:
#		target_unit.hit(100)
	

#func hit(damage):
#	if hp > 0:
#		hp -= damage


#func health_depleted():
#	# TODO respawn timer
##	
#	$CollisionShape3D.call_deferred("set", "disabled", true)
##	set_layers(0)
#	if navigation_agent:
##		#print("setting radius to 0", self)
#		remove_child(navigation_agent)
##		navigation_agent.avoidance_enabled = false
##		navigation_agent.radius = 0.01
##		remove_child(navigation_agent)
#
#	emit_signal("unit_died")


#func load_from_resource():
#	load_base_stats()
#	emit_signal("resource_loaded", character_resource)
	
	
#func load_base_stats():#resource_file : BaseCharacter):
#
##	if team == "Blue":
##		max_hp = 1000
##		hp = 1000
##	else:
#	max_hp = character_resource.hp
#	hp = character_resource.hp
#	hp_growth = character_resource.hp_growth
#
#	hp_regen = character_resource.hp_regen
#	hp_regen_growth = character_resource.hp_regen_growth
#
#	attack_speed = character_resource.attack_speed
#	attack_speed_growth = character_resource.attack_speed_growth
#
#	attack_range = character_resource.attack_range
#	attack_windup = character_resource.attack_windup
#
#	speed = character_resource.speed
#	#print("speed was set: ", speed)


#func _on_level_up():
#	level += 1
#	hp += hp_growth


# also respawn
#func spawn_unit():
#	transform.origin = spawn_location
#
#	hp = max_hp
#	state_machine.unit_status = Glob.status.FREE
#
#	if $CollisionShape3D.disabled:
#		add_child(navigation_agent)
#
#	$CollisionShape3D.call_deferred("set", "disabled", false)
#	set_layers(1)
#	if navigation_agent:
#		add_child(navigation_agent)
#		add_child(temp_nav_ref)
#		navigation_agent.call_deferred("set", "avoidance_enabled", true)
#		navigation_agent.call_deferred("set", "navigation_layer_value", 1)
#		navigation_agent.set_avoidance_enabled(true)
#		navigation_agent.set_navigation_layer_value(1, 1)
#
#	$NavigationAgent3D.avoidance_enabled = true
#	#print(hp, max_hp)
#	#print("Spawned unit %s at %s" % [self, transform.origin])
	# TODO statemachine spawn state (rooted and play animation)

#func _on_stat_change(stat_name, value):
#	emit_signal("stat_changed", stat_name, value)

func _on_mouse_entered():
	unit_scene.change_outline(0.2)
	
func _on_mouse_exited():
	unit_scene.change_outline(0)

#func set_layers(value):
#	set_collision_layer_value(1, value)
#	set_collision_layer_value(2, value)
#	set_collision_layer_value(3, value)
#
#	set_collision_mask_value(1, value)
#	set_collision_mask_value(2, value)
#	set_collision_mask_value(3, value)
