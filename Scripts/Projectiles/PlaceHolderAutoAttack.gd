# todo set collision mask on spawn
extends Node3D

var attack_owner
var target
var target_col
var speed = 10
var damage : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if target.has_node("CollisionShape3D"):
		target_col = target.get_node("CollisionShape3D")
#		#print("aa target: ", target_col.global_transform.origin.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	look_at(target)
#	#print(transform.origin, target.transform.origin)
	var direction = (target.global_transform.origin - global_transform.origin)
	
#	if target_col:
#		direction.y = target_col.global_transform.origin.y
#	else:
#		direction.y = 0
	direction.y = (target_col.global_transform.origin.y - global_transform.origin.y)
#	breakpoint
#	#print("direction: ", direction)
	transform.origin += direction.normalized() * delta * speed




#func _on_area_3d_body_entered(body : Node3D):
#	if body == target:
##		#print("I hit you! ", body)
#		body.hit(damage)
#		queue_free()
#	else:
#		#print("aa hit something different: ", body)


#func _on_timer_timeout():
##	#print(self, " expired")
#	queue_free()
