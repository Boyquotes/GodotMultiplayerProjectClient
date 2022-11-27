extends VSplitContainer

@export var box_team : String

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "PlayerBox" + box_team
	$SwitchTeamButton.button_team = box_team
