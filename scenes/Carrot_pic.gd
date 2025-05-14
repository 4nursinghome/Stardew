extends TextureButton
func _pressed():
	print("前往倉庫的按鈕")
	get_tree().change_scene_to_file("res://scenes/WarehouseScene.tscn")
