extends Node3D

# projectile stats
@export var lifespan_timer : Timer
var projectile_speed = 10
var projectile_lifespan = 1

var spawned_by : CharacterBody3D

var target = Vector3.ZERO
var direction

var msg : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
#	target = msg.target
	
	# fly straight
	target.y = transform.origin.y
	
#	#print("spawned projectile at ", transform.origin)
	look_at(target)
	direction = (transform.origin - target).normalized()
	lifespan_timer.start(projectile_lifespan)
	
	_set_collisions()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	if transform.origin.distance_to(target) < 1:
#		queue_free()
#	else:
#		#print(transform.origin.distance_to(target))
	
	transform.origin -= direction * projectile_speed * delta

#func _on_area_3d_body_entered(body):
#	#print("projectile hit ", body)
#	if body.has_method("")


func _on_projectile_lifespan_timer_timeout():
	queue_free()

func _set_collisions():
#	spawned_by
	pass
