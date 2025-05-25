extends TextureButton
func _pressed():
	print("Button to the warehouse")
	get_tree().change_scene_to_file("res://scenes/WarehouseScene.tscn")
