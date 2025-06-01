extends Control
signal home_pressed(button_name)

@onready var home_button = $homeButton
@onready var storage_button=$storageButton
@onready var borad_button=$boardButton
func _ready():
	for button in [home_button,storage_button,borad_button]:
		button.pressed.connect(_on_button_pressed)

func _on_button_pressed(button_name):
	print("nebcube")
	emit_signal("home_pressed", button_name)
	
	
