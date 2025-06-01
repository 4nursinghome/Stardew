extends Area2D
signal home_pressed
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("home_pressed","home")
