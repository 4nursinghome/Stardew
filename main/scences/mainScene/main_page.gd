extends Node2D
signal mainPage_pressed(button_name: String)

@onready var button = $button/farmButton

func _ready():
	button.button_pressed.connect(_on_button_pressed)

func _on_button_pressed(button_name):
	print("deion")
	emit_signal("mainPage_pressed", button_name)
