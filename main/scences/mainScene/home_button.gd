extends Area2D
signal pressed(button_name)

@export var button_name: String = "home"

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("pressed", button_name)
		print("essss")
