extends Control

signal request_switch_to(page_name: String)



func _on_texture_button_pressed() -> void:
	print("Task按鈕在基層被按下")
	emit_signal("request_switch_to","Task_control")
	 # Replace with function body.


func _on_texture_button_2_pressed() -> void:
	print("Jokes按鈕在基層被按下")
	emit_signal("request_switch_to","Jokes_control")
# Replace with function body.


func _on_texture_button_3_pressed() -> void:
	print("倉庫按鈕在基層被按下")
	emit_signal("request_switch_to","StoreRoom_control")
	# Replace with function body.


func _on_home_button_pressed() -> void:
	print("home按鈕在基層被按下")
	emit_signal("request_switch_to","Home")
	# Replace with function body.


func _on_farm_button_pressed() -> void:
	print("farm在基層被按下")
	emit_signal("request_switch_to","Farm_control")
	# Replace with function body.
