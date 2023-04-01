extends HBoxContainer

@export var stat_name : String
@export var value_label : Label

# icon
@export var icon_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	name = stat_name + "_row"
	value_label.name = stat_name + "_value_label"
	icon_label.name = stat_name + "_icon_label"
	icon_label.text = stat_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_value(value):
	value_label.text = str(value)
