extends ImmediateGeometry


func _draw_line(A : Vector3, B : Vector3):
#	clear()
	begin(1, null) #1 = is an enum for draw line, null is for text

	add_vertex(A)
	add_vertex(B)
	end()
