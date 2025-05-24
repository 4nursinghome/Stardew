extends Control

var joke = ["今天去買早餐時，\n後面的人拍了我的肩說：\n「我先到欸！」\n於是我微慍道：\n「我流川楓欸」","吉野櫻跟八重櫻差在哪\n\n\n插在土裡","什麼題目最時尚\n\n\n【非選題】（fashion）題","皮卡丘站起來變成什麼？\n\n\n【皮卡兵】"
,"那皮卡丘左右跳呢？\n\n\n【皮卡乓乒乓乒乓】","皮卡丘跳遠
\n\n\n【皮卡乒乓乒乓乒乓乒\n丘丘丘丘丘丘丘兵】","三代同堂的英文是什麼？\n\n\n【family 3.0】","有一天小明跟朋友去樹下野餐，\n
要走的時候發現衣服被勾住了，\n於是他就跟朋友說\n\n\n樹勾衣餒"]

func _ready():
	randomize()
	#$VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	#$VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)
	print("READY!!!!")
	$PriceLabel.text = joke[randi()%len(joke)]
func _on_back_button_pic_pressed() -> void:
	pass # Replace with function body.
	print("我成功被按下了!")
	get_tree().change_scene_to_file("res://scenes/BulletinBoard.tscn")

func _on_quit_button_pic_pressed() -> void:
	pass # Replace with function body.
	print("離開")
	get_tree().quit()
