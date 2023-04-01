extends Node3D

@export var bar : Control
@export var viewport : SubViewport
@export var player_health_bar : Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# weird bug with nodepath means $ must be used
	player_health_bar.texture = $SubViewport.get_texture()
#	#print("bar loaded")
#	#print(get_parent(), bar)
	bar.character_unit = get_parent()
	bar.connect_health_changed_signal()


#func update_bar(amount):
##	#print('bar updated', amount)
#	bar.update_bar(amount)
