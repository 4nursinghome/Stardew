extends Node2D
signal mainPage_pressed(button_name: String)
signal building_pressed(building_number: String)
@onready var buttonFarm = $button/farmButton
@onready var buttonBoard=$button/boardButton
@onready var building=$house
@onready var loading=$Loading/Sprite2D
@onready var loadingAni=$Loading/AnimatedSprite2D
@onready var buttonSkill=$button/skillButton
func _ready():
	loading.show()
	loadingAni.play("default")
	await  get_tree().create_timer(2.0).timeout
	loading.hide()
	loadingAni.hide()
	buttonFarm.button_pressed.connect(_on_button_pressed)
	buttonBoard.button_pressed.connect(_on_building_pressed)
	buttonSkill.button_pressed.connect(_on_button_pressed)
	building.building_pressed.connect(_on_building_pressed)
func _on_button_pressed(button_name):
	print("deion")
	emit_signal("mainPage_pressed", button_name)
func _on_building_pressed(building_number):
	print("building")
	emit_signal("building_pressed",building_number)
