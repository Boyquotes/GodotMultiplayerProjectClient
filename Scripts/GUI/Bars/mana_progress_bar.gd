extends TextureProgressBar

@export var mana_label : Label
@export var mana_regen_label : Label


func connect_signals(mana_component : UnitManaComponent):
	mana_component.connect("mana_changed", update_mana)
	mana_component.connect("max_mana_changed", update_max_mana)
	mana_component.connect("mana_regen_changed", update_mana_regen)
	
#	#print("connecting signals!: ", mana_component.max_mana)
	update_max_mana(mana_component.max_mana)
	update_mana(mana_component.mana)
	update_mana_regen(mana_component.mana_regen)
	
	
func update_mana(amount):
	mana_label.text = str(amount)
	value = amount
	
func update_max_mana(amount):
	max_value = amount
	
func update_mana_regen(amount):
	mana_regen_label.text = str(amount)
