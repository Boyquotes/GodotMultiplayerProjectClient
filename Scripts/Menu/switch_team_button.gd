extends Button

@export var button_team : String

# Called when the node enters the scene tree for the first time.
#func _ready():
#	button_team = get_parent().box_team


func _pressed():
	var player_node = Network.get_player_node()
#	if player_node.team != button_team:
	Network.rpc("player_switch_team", player_node.team, button_team)
