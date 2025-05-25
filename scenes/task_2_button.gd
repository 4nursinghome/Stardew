extends TextureButton

func _pressed():
	print("The button to the notice board in the task panel has been clicked")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")
