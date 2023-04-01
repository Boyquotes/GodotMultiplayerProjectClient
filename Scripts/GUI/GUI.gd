extends MarginContainer

@export var announcement_box : TextureRect

@export var health_bar : TextureProgressBar
@export var stats_container : VBoxContainer
@export var bar_container : VBoxContainer

#@export var mana_bar : TextureProgressBar
#@export var experience_bar : TextureProgressBar

@export var abilities_container : HBoxContainer
@export var ability_button : PackedScene

# dict with reference to ui parts
var gui_dict = {"health_bar" : health_bar, "stats" : stats_container}

# dict with paths to compositional ui parts
var gui_scene_paths = {"mana_bar" 	: "res://Scenes/GUI/Bars/mana_progress_bar.tscn",
						"xp_bar"	: "res://Scenes/GUI/Bars/experience_progress_bar.tscn"}

#var character_unit : CharacterUnit
var ability_nodes : Array[TextureProgressBar] = []


# Called when the node enters the scene tree for the first time.
func _ready():
#	var character_node = Network.player_controller.my_player_node.character_node

	GameState.connect("connect_ui_bars", setup_ui)

func setup_ui(character_unit):
	connect_bars(character_unit)
	connect_stats(character_unit)

func connect_bars(character_unit : CharacterUnit):
	# TODO spawn on character spawn instead of only connecting
	health_bar.connect_signals(character_unit)
	
	if character_unit.mana_component:
		add_GUI_bar("mana_bar")
		gui_dict["mana_bar"].connect_signals(character_unit.mana_component)
	
	if character_unit.experience_component:
		add_GUI_bar("xp_bar")
		gui_dict["xp_bar"].connect_signals(character_unit.experience_component)

func connect_stats(character_unit):
	stats_container.connect_signals(character_unit)


func add_GUI_bar(bar_name : String):
	var bar_scene = load(gui_scene_paths[bar_name]).instantiate()
	bar_container.add_child(bar_scene)
	gui_dict[bar_name] = bar_scene
	
	return bar_scene

func queue_announcement(msg : String):
	announcement_box.queue_announcement(msg)
	
