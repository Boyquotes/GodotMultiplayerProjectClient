extends Node3D

@onready var WaypointFlagScene = preload("res://Assets/Objects/Navigation/WaypointFlag.tscn")

var last_waypoint_flag

# Called when the node enters the scene tree for the first time.
func _ready():
	# assign camera to playernode
	Network.player_controller.WorldNode = self


	GameState.connect("click_terrain", _click_terrain)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _click_terrain(target_position):
	print("clicked at .. : ", target_position)
	
	if last_waypoint_flag:
		last_waypoint_flag.queue_free()
	var waypoint_flag = WaypointFlagScene.instantiate()
	add_child(waypoint_flag)
	waypoint_flag.transform.origin = target_position
	
	last_waypoint_flag = waypoint_flag
	Network.rpc("order_move", target_position)
