extends Control

@export var esc_window : CanvasLayer

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("esc") and esc_window.visible == false:
		esc_window.show()
	elif event.is_action_pressed("esc"):
		esc_window.hide()



func _on_button_resume_pressed():
	esc_window.hide()


func _on_button_exit_pressed():
	get_tree().quit()
