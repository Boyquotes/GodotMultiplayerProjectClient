extends TextureProgressBar

@export var xp_current_label : Label
@export var xp_max_label : Label

func connect_signals(xp_component : UnitExperienceComponent):
	xp_component.connect("xp_changed", update_xp)
	xp_component.connect("max_xp_changed", update_max_xp)

	update_max_xp(xp_component.max_xp)
	update_xp(xp_component.xp)
	
	
func update_xp(amount):
	xp_current_label.text = str(amount)
	value = amount
	
func update_max_xp(amount):
	xp_max_label.text = str(amount)
	max_value = amount
