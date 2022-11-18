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
	
	
	
func update_player_list():
	var player_slots = Network.player_slots
#	var player_slots = multiplayer.get_peers()
#	print(multiplayer.get_unique_id(), ' current players:', player_slots)
	var names_container_node = lobby_menu.get_node("PlayerBox/PlayerFieldRect/LobbyNamesContainer")
	for p in range(len(player_slots)):
		var player_id = player_slots[p]
		if player_id != 0:
			names_container_node.get_node("PlayerName" + str(p)).text = str(player_id)
		else:
			names_container_node.get_node("PlayerName" + str(p)).text = ""


















