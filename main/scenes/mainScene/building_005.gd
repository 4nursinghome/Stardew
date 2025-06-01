extends Area2D
signal building_pressed(button_name: String)
signal nextShow
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("building_pressed", "6") 
		emit_signal("nextShow","6")
