extends TextureProgressBar

@export var hp_label : Label
@export var hp_regen_label : Label



# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func connect_signals(player_character : CharacterBody3D):
	player_character.connect("health_changed", update_hp)
	player_character.connect("max_health_changed", update_max_hp)
	player_character.connect("health_regen_changed", update_hp_regen)
	
	update_max_hp(player_character.max_hp)
	update_hp(player_character.hp)
#	update_hp_regen(player_character.hp_regen)
	
	
func update_hp(amount):
#	#print("hp was updated!!!")
	hp_label.text = str(amount)
	value = amount
	
func update_max_hp(amount):
	max_value = amount
	
func update_hp_regen(amount):
	hp_regen_label.text = str(amount)
