extends Node

# adds server as player on startup with id 0
@export var debug : bool  = false

# show minion destination waypoint flags
@export var debug_pathing : bool = false

# show states in unit overheads
@export var debug_states : bool = false

var player_ui_node : Control

signal click_terrain
signal click_unit

signal connect_ui_bars
signal add_ui_ability
signal leveled_up_ability

enum States {LOBBY, IN_GAME}
var current_state = States.LOBBY
var world_node


func load_world():
	rpc('rpc_load_scene',"res://Scenes/World/World.tscn")
		
		
		
		
		

@rpc("call_local")
func spawn_ui():
	var player_ui = preload("res://Scenes/GUI/GUI.tscn")
	player_ui_node = player_ui.instantiate()
#		player_ui_node.character_node = Network.get_player_node().character_node
	get_tree().root.add_child(player_ui_node)

@rpc("call_local")
func announce(msg : String):
	print("announcing message! ", msg)
	player_ui_node.queue_announcement(msg)

@rpc
func rpc_load_scene(path):
	# have all clients load this scene
	get_tree().change_scene_to_file(path)


@rpc
func sync_game_state(new_state):
	#print("Gamestate was updated to: ", new_state)
	current_state = new_state

