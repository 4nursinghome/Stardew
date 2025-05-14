extends TextureButton

func _pressed():
	print("倉庫前往布告欄的按鈕被點擊了")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")
