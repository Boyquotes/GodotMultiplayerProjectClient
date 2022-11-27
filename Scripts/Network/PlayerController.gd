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
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if GameState.current_state != GameState.States.IN_GAME:
		return
		
	if event.is_action_pressed("right_click"):
		right_click_action()
	elif event.is_action_pressed("ability1"):
		fire_ability(1)
	elif event.is_action_pressed("ability2"):
		fire_ability(2)
	elif event.is_action_pressed("ability3"):
		fire_ability(3)
	elif event.is_action_pressed("ability4"):
		fire_ability(4)

func right_click_action():
		
	var intersection = get_mouse_intersection("no_walls")

	if not intersection.is_empty():
		print("Rightclick to: ", intersection.position)
		print("Intersection : ", intersection.collider, intersection.collider.get_groups())
		var intersection_groups = intersection.collider.get_groups()
		if &'Terrain' in intersection_groups:
			GameState.emit_signal("click_terrain", intersection.position)
		elif &"Unit" in intersection_groups:
			GameState.emit_signal("click_unit", intersection.collider)
	else:
		print("empty intersection!")


func fire_ability(ability_num):
	var intersection = get_mouse_intersection("terrain")
	if not intersection.is_empty():
		my_player_node.fire_ability(ability_num, intersection)


func spawn_camera(position : Vector3):
	print("Loading player camera for server")
	var camera = preload("res://Scenes/World/Utilities/Camera.tscn")
	player_camera = camera.instantiate()
#	print(my_player_node)
	player_camera.player_character = my_player_node.character_node
	add_child(player_camera)
	player_camera.transform.origin += position

func get_mouse_intersection(ray_collision):
	var mouse_position = get_viewport().get_mouse_position()
	ray_origin = player_camera.project_ray_origin(mouse_position)
	ray_target = ray_origin + player_camera.project_ray_normal(mouse_position) * 2000

	var space_state = player_camera.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
	
	if ray_collision == "all":
		var intersection = space_state.intersect_ray(ray_query)
		return intersection
		
	elif ray_collision == "no_walls":
		# also no projectiles
		ray_query.collision_mask = 125
	
	elif ray_collision == "terrain":
		var col_mask = 1
		ray_query.collision_mask = 1
	
	var intersection = space_state.intersect_ray(ray_query)
	
	
	return intersection
