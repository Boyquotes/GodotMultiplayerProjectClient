extends Node

signal click_terrain
signal click_unit

enum States {LOBBY, IN_GAME}
var current_state = States.LOBBY

func load_world():
	rpc('rpc_load_scene',"res://Scenes/World/World.tscn")
		
		
@rpc
func rpc_load_scene(path):
	# have all clients load this scene
	get_tree().change_scene_to_file(path)


@rpc
func sync_game_state(new_state):
	print("Gamestate was updated to: ", new_state)
	current_state = new_state

