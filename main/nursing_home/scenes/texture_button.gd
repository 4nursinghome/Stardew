extends TextureButton
func _pressed():
	print("Go to task")
	get_tree().change_scene_to_file("res://scenes/TaskScene.tscn")
	
