extends Node2D
signal mainPage_pressed(button_name: String)
signal building_pressed(building_number: int)
@onready var buttonFarm = $button/farmButton
@onready var buttonBoard=$button/boardButton
@onready var building=$house
func _ready():
	buttonFarm.button_pressed.connect(_on_button_pressed)
	buttonBoard.button_pressed.connect(_on_building_pressed)
	building.building_pressed.connect(_on_building_pressed)
func _on_button_pressed(button_name):
	print("deion")
	emit_signal("mainPage_pressed", button_name)
func _on_building_pressed(building_number):
	print("building")
	emit_signal("building_pressed",building_number)
