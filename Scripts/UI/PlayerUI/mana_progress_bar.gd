extends TextureProgressBar

@export var mana_label : Label
@export var mana_regen_label : Label


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func connect_signals(player_character : CharacterBody3D):
	pass
#	player_character.connect("mana_changed", update_mana)
#	player_character.connect("max_mana_changed", update_max_mana)
#	player_character.connect("mana_regen_changed", update_mana_regen)
	
#	#print("connecting signals!: ", player_character.max_mana)
#	update_max_mana(player_character.max_mana)
#	update_mana(player_character.mana)
#	update_mana_regen(player_character.mana_regen)
	
	
func update_mana(amount):
	mana_label.text = str(amount)
	value = amount
	
func update_max_mana(amount):
	max_value = amount
	
func update_mana_regen(amount):
	mana_regen_label.text = str(amount)
