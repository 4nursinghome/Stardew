extends Control
signal request_switch_to(page_name: String)

var joke = ["I told my computer I\nneeded a break...\nNow it won’t stop\nsending me vacation ads.",
			"Why don’t skeletons\nfight each other?\nBecause they don’t haven\nthe guts.",
			"Parallel lines have so much in common.\nIt’s a shame they’ll never meet.",
			"I would tell you a construction joke...\nI’m still working on it.",
			"Why don’t eggs tell jokes?\nBecause they’d crack each other up.",
			"I used to play piano by ear,\nbut now I use my hands.",
			"Did you hear about the guy who invented Lifesavers?\nHe made a mint.",
			"Why can't your nose be 12 inches long?\nBecause then it would be a foot.",
			"I asked my dog what’s two minus two.\nHe said nothing.",
			"Parallel lines have so much in common.\nIt’s a shame they’ll never meet."]

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
