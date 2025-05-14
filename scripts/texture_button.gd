extends TextureButton

func _pressed():
	print("市場紙張被點了")
	get_tree().change_scene_to_file("res://scenes/MarketScene.tscn")
