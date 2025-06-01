extends Control
signal skill_pressed(skill_name)

@onready var skill1_button = $skill1Button
@onready var escape_button = $escapeButton
@onready var ult_button = $ULTButton
@onready var special_button=$specialButton
func _ready():
	for button in [skill1_button, escape_button, ult_button,special_button]:
		print("????????")
		button.pressed.connect(_on_skill_button_pressed)

func _on_skill_button_pressed(skill_name):
	emit_signal("skill_pressed", skill_name)
	
