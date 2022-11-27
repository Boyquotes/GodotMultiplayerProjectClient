extends Node


signal team_joined
signal team_left

@onready var team_dict = {}
		
@onready var num_players = 0


func _ready():
	# create the two default teams
	self.create_team("Blue", Color.BLUE)
	self.create_team("Red", Color.RED)
	self.create_team("Spectators", Color.GREEN_YELLOW)
	
	# could calculate/resize based on Network max num players
	team_dict["Spectators"].max_size = 0
	


func get_team(team_name : String):
	return team_dict[team_name]

func join_smallest_team(player_id):
	var smallest_team = team_dict[team_dict.keys()[0]]
	for team_name in team_dict:
		var _team = team_dict[team_name]
		if _team.is_full():
			continue
		elif _team.team_size() < smallest_team.team_size():
			smallest_team = _team
	
#	print("smallest team was ", smallest_team)
	if not smallest_team.is_full():
		join_team(player_id, smallest_team.name)
		return smallest_team.name
	else:
		return false
	


func join_team(player_id : int, team_name : String):
	# Only use when players first join
	if team_dict[team_name].is_full():
		return false
	
	num_players += 1
	team_dict[team_name].add_member(player_id)
#	print("current teams: ", team_dict)
	emit_signal("team_joined", str(player_id), team_name)
	
func leave_team(player_id : int, team_name : String):
	num_players -= 1
	team_dict[team_name].remove_member(player_id)
	print(player_id, " left team ", team_name)
	emit_signal("team_left", str(player_id), team_name)
	
func switch_team(player_id : int, team_start : String, team_end : String):
	if team_dict[team_end].is_full():
		push_error("Tried to switch %s to team %s (full)" % [player_id, team_end])
	else:
		print("Switched player %s from team %s to team %s" % [player_id, team_start, team_end])
		team_dict[team_start].remove_member(player_id)
		team_dict[team_end].add_member(player_id)
	print(player_id, " left team ", team_start)
	emit_signal("team_left", str(player_id), team_start)
	emit_signal("team_joined", str(player_id), team_end)

# TODO create names field etc in lobby screen
func create_team(team_name : String, team_color : Color):
	team_dict[team_name] = load("res://Scripts/Network/Team.gd").new()
	team_dict[team_name].name = team_name
	if team_color:
		team_dict[team_name].team_color = team_color
	else:
		team_dict[team_name].team_color = Color.PURPLE
