extends Control
signal button_pressed(button_name)

@onready var farm_button = $farmButton

func _ready():
	for button in [farm_button]:
		button.pressed.connect(_on_button_pressed)
func _on_button_pressed(button_name):
	emit_signal("button_pressed", button_name)
	print("haeee")
