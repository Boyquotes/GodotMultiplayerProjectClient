extends BaseAbility

class_name SkillShotAbility


var loaded_ability
var projectile_speed : PackedFloat32Array
var projectile_lifespan : PackedFloat32Array

func fire(msg):
	# TODO this is really messy
#	#print("Skillshot! ", msg)
	var loaded_ability = ability_scene.instantiate()
	loaded_ability.target = msg["position"] + Vector3(0, 1.5, 0)
	loaded_ability.transform.origin = msg["projectile_parent"].get_parent().transform.origin
	msg["projectile_parent"].add_child(loaded_ability)
