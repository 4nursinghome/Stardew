extends TextureButton
func _pressed():
	print("Go to the detailed quest scroll panel")
	get_tree().change_scene_to_file("res://scenes/TaskDetailScene.tscn")
