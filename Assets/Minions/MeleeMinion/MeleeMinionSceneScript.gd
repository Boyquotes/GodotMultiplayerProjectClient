extends Node3D

@onready var newMaterial = StandardMaterial3D.new()
@onready var child_list : Array = get_children()
@onready var parent_unit : BaseUnit = get_parent()

# TODO change outline color based on client team

#func _ready():
#	change_outline(0.2)


func change_albedo(color : Color):
	for child in child_list:
		newMaterial.albedo_color = color
		child.material_override = newMaterial #Assign new material to material overrride



func change_outline(grow):
	for child in child_list:
		var material_next_pass : Material = child.material.next_pass
		material_next_pass.grow_amount = grow
		
		# DO THIS FOR CLIENTS
#		if parent_unit.team == Network.get_player_node().team:
#			material_next_pass.albedo_color = Color.GREEN
#		else:
#			material_next_pass.albedo_color = Color.RED
			
