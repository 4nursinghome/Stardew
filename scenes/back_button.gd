extends TextureButton

func _pressed():
	print("任務前往布告欄的按鈕被點擊了")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")
