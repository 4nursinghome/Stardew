extends TextureButton

func _pressed():
	print("The warehouse to notice board button was clicked")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")
