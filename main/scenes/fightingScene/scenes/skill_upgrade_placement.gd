extends Control
@onready var homeButton=$homeButton
signal home_pressed(name)
func _ready() -> void:
	homeButton.home_pressed.connect(on_home_pressed)
func on_home_pressed(name):
	emit_signal("home_pressed",name)
