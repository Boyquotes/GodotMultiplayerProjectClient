extends Node3D

@onready @export var bar : TextureProgressBar
@onready @export var viewport : SubViewport
@onready @export var player_health_bar : Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# weird bug with nodepath means $ must be used
	player_health_bar.texture = $SubViewport.get_texture()
	
	bar.player_character = get_parent()
	bar.connect_health_changed_signal()



#func update_bar(amount):
##	print('bar updated', amount)
#	bar.update_bar(amount)
