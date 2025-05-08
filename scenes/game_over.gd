extends Control
@onready var restartButton=$restartButton
@onready var back_to_farm = $back_to_farm_Button
func _ready() :
	restartButton.pressed.connect(on_restart_button_pressed)
func on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")  # 重新開始遊戲

func on_back_to_farm_pressed():
	get_tree().quit()
