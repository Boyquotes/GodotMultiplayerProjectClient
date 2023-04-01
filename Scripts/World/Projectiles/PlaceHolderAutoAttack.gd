extends Node3D

var attack_owner
var target
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
##	look_at(target)
#	var direction = (transform.origin - target.transform.origin).normalized()
#	transform.origin -= direction * delta * speed




#func _on_area_3d_body_entered(body : Node3D):
#	if body == target:
#		#print("I hit you! ", body)
#		queue_free()
#	else:
#		#print("aa hit something different: ", body)
