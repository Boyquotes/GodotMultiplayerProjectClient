extends Control

@onready var start_menu = $StartMenu
@onready var join_menu = $JoinMenu
@onready var lobby_menu = $LobbyMenu


func _on_startmenu_join_button_pressed():
	join_menu.show()
	start_menu.hide()


func _on_joinmenu_back_button_pressed():
	start_menu.show()
	join_menu.hide()


func _on_joinmenu_join_button_pressed():
	var server_ip = join_menu.get_node("IPAdressField").text
	Network.start_client(server_ip)

	lobby_menu.get_node("LobbyTypeLabel").text = "Client"
	lobby_menu.get_node("LobbyPeerIDLabel").text = str(multiplayer.get_unique_id())
	# ui transition
	lobby_menu.show()
	join_menu.hide()



func _on_lobbymenu_back_pressed():
#	if not multiplayer.is_server():
	Network.peer.close_connection()
#	update_player_list()
		
	start_menu.show()
	lobby_menu.hide()






func _get_names_container(box_name):
	return lobby_menu.get_node("PlayerBox" + box_name + "/PlayerFieldRect/LobbyNamesContainer")



@rpc
func rpc_on_team_joined(player_id, team, team_color):
	#print("on team joined rpc")
	# update player node
	var player_node = Network.get_player_node_id(player_id)
	player_node.team = team
	player_node.team_color = team_color
#	#print("%s now has team %s with color %s" % [player_node, player_node.team, player_node.team_color])
	
	var names_container = _get_names_container(team)
	var player_label = load("res://Scenes/Menu/player_label_lobby.tscn").instantiate()
#	player_label
	player_label.name = "player_label_" + str(player_id)
	player_label.text = str(player_id)
	
	# color is known under player node (save on network traffic)
	player_label.self_modulate = team_color
	
	names_container.add_child(player_label)

@rpc
func rpc_on_team_left(player_id, team):
	var names_container = _get_names_container(team)
	var player_label = names_container.get_node("player_label_" + player_id)
	#print("player_label_" + player_id)
	player_label.queue_free()












