# Navigation Component
# component that handles movement of any base unit
# MUST HAVE CHILDREN:
# 	- navigation agent

class_name UnitNavigationComponent
extends UnitComponent

@onready var nav_agent : NavigationAgent3D = get_parent().navigation_agent
@export var state_machine : StateMachine

# Called when the node enters the scene tree for the first time.
#func setup_navigation_states():
func _ready():
#	var walk_state_script = load("res://Scripts/Units/UnitComponents/StateMachine/UnitNavigationComponent/StateWalk.gd")
#	var walk_to_unit_state_script = load("res://Scripts/Units/UnitComponents/StateMachine/UnitNavigationComponent/StateWalkToUnit.gd")
#
#	var walk_state_node = Node.new()
#	var walk_to_unit_state_node = Node.new()
#
#	walk_state_node.set_script(walk_state_script)
#	walk_to_unit_state_node.set_script(walk_to_unit_state_script)
#
#	walk_state_node.name = "Walk"
#	walk_to_unit_state_node.name = "WalkToUnit"
#
#	walk_state_node.nav_agent = nav_agent
#	walk_to_unit_state_node.nav_agent = nav_agent
#

#	#print("assigned parent with speed: ", get_parent(), get_parent().speed)
#
#	state_machine.add_child(walk_state_node)
#	state_machine.add_child(walk_to_unit_state_node)
	var parent_unit = get_parent()


	var walk_state_node = state_machine.get_node("Walk")
	var target_unit_state_node = state_machine.get_node("TargetUnit")


	nav_agent = parent_unit.navigation_agent
	walk_state_node.nav_agent = nav_agent
	target_unit_state_node.nav_agent = nav_agent
	
	walk_state_node.parent_unit = parent_unit
	target_unit_state_node.parent_unit = parent_unit
	


func move_to_position(target_position : Vector3):
#	#print("move to: ", target_position)
	state_machine.transition_to("Walk", {"target_position" : target_position})
	
func move_to_target(target_unit : BaseUnit):
	state_machine.transition_to("TargetUnit", {"target_unit" : target_unit})

