extends TextureProgressBar

# TODO add hover description
# TODO make clickable

var cooldown_timer : Timer
var ability_num : int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = float(cooldown_timer.time_left)


func connect_gamestate():
	# TODO put in ready?
	GameState.connect("leveled_up_ability", update_ability)
	
	
func update_ability(num, msg):
	if ability_num == num:
		max_value = msg["cooldown"]
