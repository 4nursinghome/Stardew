extends TextureButton

func _pressed():
	print("Market paper is clicked")
	get_tree().change_scene_to_file("res://scenes/Jokes.tscn")
