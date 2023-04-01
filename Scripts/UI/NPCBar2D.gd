extends Control

var character_unit : BaseUnit
@export var health_bar : TextureProgressBar



func connect_health_changed_signal():
#	character_unit
	character_unit.connect("health_changed", update_hp)
	character_unit.connect("max_health_changed", update_max_hp)
	
	await character_unit.ready
	
	update_hp(character_unit.hp)
	update_max_hp(character_unit.max_hp)
	
	# TODO add debug button
	if GameState.debug_states:
		character_unit.state_machine.connect("transitioned", _on_state_change)
	
func update_hp(amount):
	health_bar.value = amount


func update_max_hp(amount):
	health_bar.max_value = amount


func _on_state_change(state):
	get_node("Label").text = state
