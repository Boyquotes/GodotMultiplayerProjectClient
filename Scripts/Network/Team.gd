class_name Team

extends Node

#var team_name : String
var team_color : Color

var members := []
var max_size : int = 4

func add_member(player_id):
	print("adding %s to team %s" % [player_id, name])
	if len(members) <= max_size:
		members.append(player_id)
	else:
		push_error("Tried to add %s to team %s (full)" % [player_id, name])

func remove_member(player_id):
	if not members.is_empty():
		members.erase(player_id)
#	push_error("Tried to remove %s from team %s but didn't occur" % [player_id, team_name])

func team_size():
#	print(name, " number of members: ", len(members))
	return len(members)

func is_full():
	if len(members) == max_size:
#		push_error("Team %s (full)" % [self.name])
		return true
	else:
		return false
