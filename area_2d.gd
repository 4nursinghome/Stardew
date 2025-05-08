extends Area2D

signal clicked
func _ready():
	input_pickable = true
	print("CollisionShape2D:", $CollisionShape2D.shape)
	print("input_pickable:", input_pickable)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("點擊到Area2D了")
		emit_signal("clicked")
