extends TextureButton

func _pressed():
	print("The task's bulletin board button was clicked")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")
