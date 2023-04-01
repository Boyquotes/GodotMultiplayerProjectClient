extends Control

var character_unit : BaseUnit
@export var bar_name : Label
@export var health_bar : TextureProgressBar
@export var mana_bar : TextureProgressBar
# Called when the node enters the scene tree for the first time.
#func _ready():
#	#print("playerbar2d")

func connect_health_changed_signal():
#	character_unit
	character_unit.connect("health_changed", update_hp)
	character_unit.connect("max_health_changed", update_max_hp)
	
	if character_unit.mana_component:
		character_unit.mana_component.connect("mana_changed", update_mana)
		character_unit.mana_component.connect("max_mana_changed", update_max_mana)
	
	await character_unit.ready
	
	# initialize values once
	update_hp(character_unit.hp)
	update_max_hp(character_unit.max_hp)
#	update_mana(character_unit.mana)
#	update_max_mana(character_unit.max_mana)
	update_label(character_unit.get_parent().name)
	update_color(character_unit.team)

	if GameState.debug_states:
		character_unit.state_machine.connect("transitioned", _on_state_change)

func update_label(text):
	bar_name.text = text


func update_hp(amount):
#	#print("set current: ", amount)
	health_bar.value = amount

func update_max_hp(amount):
#	#print("set max: ", amount)
	health_bar.max_value = amount


func update_mana(amount):
#	#print("set current: ", amount)
	mana_bar.value = amount

func update_max_mana(amount):
#	#print("set max: ", amount)
	mana_bar.max_value = amount


func update_color(team):
	# TODO change color instead of different resource
	$TextureRect.texture = load("res://Assets/UI/PlayerBar%s.tres" % team)


func _on_state_change(state):
	get_node("PlayerBarLabel").text = state
