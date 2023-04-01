extends State



#func _ready():
#	if unit.team == "Red":
#		current_progress = 1
#		ratio_sample_interval = -ratio_sample_interval
#		#print("new ratio", ratio_sample_interval)
	
	

func enter(_msg := {}) -> void:
	# get next navigation target if arrived
#	if _msg.has("arrived") and _msg["arrived"]:
#		current_progress += ratio_sample_interval
#		current_destination = get_position_on_path(current_progress)

		
#	#print("walking to ", current_destination, " with lane curve points: ", get_parent().get_parent().get_parent().curve.get_baked_points())
	if state_machine.unit_status == Glob.status.DEAD:
		state_machine.transition_to("Dead", {})
	
	
	var body_list : Array[Node3D] = state_machine.unit_area.get_overlapping_bodies()
	
	if not body_list.is_empty():
#		if body_list.size() == 1:
#			#print("Bodies: ", body_list)
		for body in body_list:
			
			# dont target dead units
			if body is BaseUnit and body.team != state_machine.get_parent().team and not body.state_machine.unit_status == Glob.status.DEAD:
				# TODO add attack structure (check if body is type structureunit
				
				# attack structure
				# attack unit
				
				state_machine.transition_to("TargetUnit", {"target_unit" : body})
				return

	state_machine.transition_to("Walk", {})


