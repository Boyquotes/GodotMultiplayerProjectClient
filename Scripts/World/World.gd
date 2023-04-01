extends Node3D

@onready var WaypointFlagScene = preload("res://Assets/Objects/Navigation/WaypointFlag.tscn")

var last_waypoint_flag

# Called when the node enters the scene tree for the first time.
func _ready():
	# assign camera to playernode
	Network.player_controller.WorldNode = self


	GameState.connect("click_terrain", _click_terrain)
	GameState.connect("click_unit", _click_unit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _click_terrain(click_position):
	#print("clicked at .. : ", click_position)
	
	if last_waypoint_flag:
		last_waypoint_flag.queue_free()
	var waypoint_flag = WaypointFlagScene.instantiate()
	add_child(waypoint_flag)
	waypoint_flag.transform.origin = click_position
	
	last_waypoint_flag = waypoint_flag
	
	Network.rpc("order_move", click_position)
		
		
func _click_unit(unit):
	var player_node = Network.get_player_node()
#	if player_node.team != unit.team:
	Network.rpc("order_attack", unit.get_path())
