extends Control

var player_character
@export var bar_name : Label
@export var progress_bar : TextureProgressBar
# Called when the node enters the scene tree for the first time.
#func _ready():


func connect_health_changed_signal():
	player_character.connect("health_changed", update_bar)
	player_character.connect("max_health_changed", update_max)
	
	await player_character.ready
	
	# initialize values once
	update_bar(player_character.current_hp)
	update_max(player_character.max_hp)
	update_label(player_character.get_parent().name)

func update_label(text):
	bar_name.text = text


func update_bar(amount):
#	print("set current: ", amount)
	progress_bar.value = amount

func update_max(amount):
#	print("set max: ", amount)
	progress_bar.max_value = amount
