class_name UnitComponentAnimationManager
extends UnitComponent

@export var animation_player : AnimationPlayer
@export var state_machine : StateMachine

var state_to_animation = {"Idle" : "Idle", "Walk" : "Run", "TargetUnit" : "Walk", "AttackUnit" : "Walk", "Dead" : "Idle"}

# Called when the node enters the scene tree for the first time.
func _ready():
	if animation_player:
		state_machine.connect("transitioned", play_animation)


func play_animation(state_name):
	var animation_name = state_to_animation[state_name]
	if animation_player.get_animation(animation_name):
		animation_player.play(animation_name)
