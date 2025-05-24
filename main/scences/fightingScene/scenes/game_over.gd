extends Control
signal back_to_main_pressed(button_name:String)
@onready var restartButton=$restartButton
@onready var back_to_farm = $back_to_main_Button
func _ready() :
	restartButton.pressed.connect(on_restart_button_pressed)
func on_restart_button_pressed():
	get_tree().reload_current_scene()  # 重新開始遊戲

func on_back_to_main_pressed():
	emit_signal("back_to_main_pressed","home")
	
