extends CharacterBody3D




func _ready():
	var parent_node = get_parent()
	if parent_node.name == str(Network.multiplayer.get_unique_id()):
		get_parent().character_node = self
		Network.player_controller.spawn_camera()
