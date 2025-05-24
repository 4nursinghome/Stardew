extends Control
signal home_pressed(button_name)

@onready var home_button = $homeButton

func _ready():
	for button in [home_button]:
		button.pressed.connect(_on_button_pressed)

func _on_button_pressed(button_name):
	print("nebcube")
	emit_signal("home_pressed", button_name)
	
	
