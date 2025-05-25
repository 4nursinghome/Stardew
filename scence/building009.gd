extends Area2D

func _ready():
	connect("input_event", Callable(self, "_on_building_clicked"))

func _on_building_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scence/picture/scence009.tscn")
