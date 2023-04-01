# displays stats that all baseunits have

extends VBoxContainer

var stats_dict : Dictionary = {"level" : 1}
@onready var statsrow_scene = preload("res://Scenes/UI/PlayerUI/stats_row.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func connect_signals(player_character):
	player_character.connect("stat_changed", _on_stat_change)

	for key in stats_dict:
		add_stat_row(key, stats_dict[key])

func add_stat_row(stat_name, value):
	stats_dict[stat_name] = value
	
	var statsrow_node = statsrow_scene.instantiate()
	
	statsrow_node.stat_name = stat_name
	statsrow_node.change_value(value)
	
	add_child(statsrow_node)

func _on_stat_change(stat_name, value):
	if stat_name not in stats_dict:
#		#print("### UI on stat change error, stat missing: ", stat_name, stats_dict)
		add_stat_row(stat_name, value)
	else:
		get_node(stat_name + "_row").change_value(value)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
