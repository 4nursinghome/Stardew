extends Control
signal restart(button_name: String)
signal end_game
signal back_to_main_pressed(button_name:String)
@onready var restartButton=$restartButton
@onready var back_to_main = $back_to_main_Button
func _ready() :
	restartButton.pressed.connect(on_restart_button_pressed)
	back_to_main.pressed.connect(on_back_to_main_pressed)
func on_restart_button_pressed():
	emit_signal("restart","fight")

func on_back_to_main_pressed():
	skillStats.Win()
	print(back_to_main)
	emit_signal("back_to_main_pressed","home")
	
