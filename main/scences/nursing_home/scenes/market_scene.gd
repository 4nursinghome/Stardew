extends Control
signal request_switch_to(page_name: String)

var joke = ["什麼題目最時尚\n\n\n【非選題】（fashion）題","三代同堂的英文是什麼？\n\n\n【family 3.0】","有一天小明跟朋友去樹下野餐，\n
要走的時候發現衣服被勾住了，\n於是他就跟朋友說\n\n\n樹勾衣餒","有一天 有一隻魚深海魚\n在海裡游阿游\n但他一點也不開心\n為什麼?\n因為他壓力好大","劉備 字玄德\n張飛 字翼德\n伍佰字?? 心得"]

func _ready():
	randomize()
	#$VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	#$VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)
	print("READY!!!!")
	$PriceLabel.text = joke[randi()%len(joke)]

#以下這段為原本切換頁面的程式，為了整合先註解掉	
#func _on_back_button_pic_pressed() -> void:
#	pass # Replace with function body.
#	print("be pressed!")
#	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")

#func _on_quit_button_pic_pressed() -> void:
#	pass # Replace with function body.
#	print("EXIT")
#	get_tree().quit()


func _on_back_button_pic_pressed() -> void:
	print("back在基層被按下")
	emit_signal("request_switch_to","NoticeItem_control")
	# Replace with function body.
