extends Area2D
signal pressed(skill_name)

@export var skill_name: String = "escape"

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("pressed", skill_name)
