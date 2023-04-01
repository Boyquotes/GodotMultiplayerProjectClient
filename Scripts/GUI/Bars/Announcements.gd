extends TextureRect
@export var msg_timer : Timer
@export var announcement_label : Label

var displaying : bool = false
var msg_queue : PackedStringArray = []


# Called when the node enters the scene tree for the first time.
func _ready():
	next_announcement()


func queue_announcement(msg : String):
	msg_queue.append(msg)
	
	if not displaying:
		next_announcement()




func _on_announcement_timer_timeout():
	next_announcement()
	
func next_announcement():
	if msg_queue.is_empty():
		displaying = false
		self.hide()
	else:
		announcement_label.text = msg_queue[0]
		
		if not displaying:
			self.show()
			displaying = true
			
		msg_timer.start()
		msg_queue.remove_at(0)
	
