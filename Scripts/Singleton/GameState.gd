extends Node

signal click_terrain


func load_world():
	rpc('rpc_load_scene',"res://Scenes/World/World.tscn")
		
		
@rpc
func rpc_load_scene(path):
	# have all clients load this scene
	get_tree().change_scene_to_file(path)

#@rpc
#func spawn_players():
#	for slot in range(Network.player_slots.size()):
#		var p = Network.player_slots[slot]
#		if p != 0:
#			Network.get_player_node_id(p).spawn_player_character(slot)



