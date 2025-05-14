extends Control



func _ready():
	#$VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	#$VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)
	print("READY!!!!")
	$PriceLabel.text = "今日價格波動：\n胡蘿蔔：90 → 88"
func _on_back_button_pic_pressed() -> void:
	pass # Replace with function body.
	print("我成功被按下了!")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")

func _on_quit_button_pic_pressed() -> void:
	pass # Replace with function body.
	print("離開")
	get_tree().quit()
