extends TextureButton
func _pressed():
	print("前往任務")
	get_tree().change_scene_to_file("res://scenes/TaskScene.tscn")
	
