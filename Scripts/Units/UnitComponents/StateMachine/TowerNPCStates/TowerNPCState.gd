class_name MinionState
extends State

# Called when the node enters the scene tree for the first time.
func _ready():
	var aggro_area = get_parent().unit_area
	aggro_area.connect("body_entered", _body_entered)
#	#print("aggro : ", aggro_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _body_entered(body : Node3D):
	# save team in statemachine to make it faster?
	if body is BaseUnit and body.team != state_machine.get_parent().team:
#		#print("Enemy body entered area! ", body)
		state_machine.transition_to("Idle", {})
#	else:
#		#print("Body is not base unit or friendly", body)
