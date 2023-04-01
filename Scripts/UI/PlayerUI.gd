extends MarginContainer

@export var health_bar : TextureProgressBar
@export var mana_bar : TextureProgressBar
@export var experience_bar : TextureProgressBar
@export var stats_container : VBoxContainer

@export var abilities_container : HBoxContainer
@export var ability_button : PackedScene


var character_unit : CharacterUnit
var ability_nodes : Array[TextureProgressBar] = []


# Called when the node enters the scene tree for the first time.
func _ready():
#	var character_node = Network.player_controller.my_player_node.character_node

	GameState.connect("connect_ui_bars", setup_ui)
	GameState.connect("add_ui_ability", add_ability)
	
func add_ability(resource : BaseAbility, ability_num, cooldown_timer):
#	#print("add ability: ", ability_num)
	var _ability : TextureProgressBar = ability_button.instantiate()
	
	_ability.name = "ability_" + str(ability_num)
	_ability.texture_under = resource.ability_icon
	_ability.cooldown_timer = cooldown_timer
	_ability.ability_num = ability_num
	
	_ability.connect_gamestate()
	
	ability_nodes.append(_ability)
	abilities_container.add_child(_ability)


#func update_ability(resource, ability_num):
#	ability_nodes[ability_num].update_ability(resource)


func setup_ui(character_unit):
	connect_bars(character_unit)
	connect_stats(character_unit)

func connect_bars(character_unit):
	# TODO spawn on character spawn instead of only connecting
	health_bar.connect_signals(character_unit)
	mana_bar.connect_signals(character_unit)
	experience_bar.connect_signals(character_unit)

func connect_stats(character_unit):
	stats_container.connect_signals(character_unit)
