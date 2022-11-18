# This node handles signal emission from player
# and move own player character locally maybe?

extends Node

var my_player_node : Node
var WorldNode : Node3D
var player_camera : Camera3D


# click signals
var ray_origin = Vector3()
var ray_target = Vector3()
var intersection_groups

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("right_click"):
		right_click_action()


func right_click_action():
	print(player_camera)
	var mouse_position = get_viewport().get_mouse_position()
	ray_origin = player_camera.project_ray_origin(mouse_position)
	ray_target = ray_origin + player_camera.project_ray_normal(mouse_position) * 2000

	var space_state = player_camera.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
	var intersection = space_state.intersect_ray(ray_query)

	if not intersection.is_empty():
		print("walking to: ", intersection.position)
		GameState.emit_signal("click_terrain", intersection.position)
	else:
		print("empty intersection!")

func spawn_camera():
	print("Loading player camera for server")
	var camera = preload("res://Scenes/World/Utilities/Camera.tscn")
	player_camera = camera.instantiate()
	print(my_player_node)
	player_camera.player_character = my_player_node.character_node
	add_child(player_camera)
