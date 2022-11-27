extends Node

# Network script on server and client must have same rpc methods or connection will fail

const DEFAULT_PORT = 8006

@onready var player_controller : Node = $PlayerController
const Player = preload("res://Scenes/Network/PlayerNode.tscn")

var player_slots = [0, 0, 0, 0, 0, 0, 0, 0]
var num_teams = 2

var peer = ENetMultiplayerPeer.new()


func start_client(ip):
	var create_client_res
	if ip == "":
		print("connecting to localhost")
		create_client_res = peer.create_client("localhost", DEFAULT_PORT)
	else:
		create_client_res = peer.create_client(ip, DEFAULT_PORT)
	print('res: ', create_client_res)
	multiplayer.set_multiplayer_peer(peer)


func get_player_node():
	# return self playernode
#	print("players children: ", player_controller.get_children())
	return player_controller.get_node(str(multiplayer.get_unique_id()))
	

func get_player_node_id(id):
	return player_controller.get_node(str(id))


@rpc
func sync_player_team(player_id, team, team_color):
	var player_node = get_player_node_id(player_id)
	player_node.team = team
	player_node.team_color = team_color

@rpc(any_peer)
func player_switch_team(team_start, team_end):
	pass
	

@rpc(any_peer)
func order_move(_position):
	pass

@rpc(any_peer)
func order_attack(_node_path):
	pass
