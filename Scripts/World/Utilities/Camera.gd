extends Camera3D

@export var area_percent: float = 0.1
@export var speed: int = 100
@export var MAX_ANG_SPEED: int = 50
@export var MOUSE_SENSITIVITY: float = 0.001

var angl = -1
var angr = 1
var dir = Vector3(0,0,0)
var pos = Vector2(0,0)
var crsr = Vector2(0,0)

@export var start_fov: int = 70
@export var zoom_factor: float = 5.0
@export var max_zoom: int = start_fov
@export var min_zoom: int = start_fov - 35

var zoom_dir = 0
var loc = transform.origin

var locked_camera = false
var player_character : CharacterBody3D
@onready var camera_offset = transform.origin

func _ready():
	set_process(true)
	fov = start_fov
	
	# locked camera
#	toggle_camera_lock()

	
	
	# full screen
#	OS.set_window_fullscreen(!OS.window_fullscreen)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	
func _input(event):
	if event.is_action_pressed("toggle_camera_lock"):
		toggle_camera_lock()
	
	if event is InputEventMouseMotion: 
		crsr = event.position

	loc = transform.origin
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if fov > min_zoom:
					fov -= zoom_factor

			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if fov < max_zoom:
					fov += zoom_factor


func _process(delta):
	if locked_camera:
		transform.origin = player_character.transform.origin + camera_offset
	else:
		pos = get_viewport().size
		
		
		dir = Vector3.ZERO
		var h_edge = int(pos.x*area_percent)
		var v_edge = int(pos.y*area_percent)
		if crsr.x < h_edge:
			dir.x -=  1 - (crsr.x / (h_edge + 0.1))
		elif crsr.x > (pos.x - h_edge):
			dir.x += 1 - ((pos.x - crsr.x) / (h_edge + 0.1))
		
		if crsr.y < v_edge:
			dir.z -= 1 - (crsr.y / (v_edge + 0.1))
		
		elif crsr.y > (pos.y-v_edge):
			dir.z += 1 - ((pos.y - crsr.y) / (v_edge + 0.1))
			
		global_transform.origin += dir*delta*speed*(fov / (2 * start_fov))
		

func toggle_camera_lock():
#	#print(player_cam)
	if locked_camera:
		locked_camera = false
#		clear_current()
#		player_cam.make_current()
#		self.current = true
	else:
		locked_camera = true
#		player_cam.current = true
#		player_cam.clear_current()
#		self.make_current()# = false
#		#print(player_cam.get_camera_transform)
#		self.transform.origin = player_cam.get_camera_transform().origin
