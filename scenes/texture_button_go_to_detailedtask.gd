extends TextureButton
func _pressed():
	print("前往詳細任務卷軸面板")
	get_tree().change_scene_to_file("res://scenes/TaskDetailScene.tscn")
