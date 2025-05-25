extends Control
signal building_pressed(building_name)

@onready var Building1 = $Building001
@onready var Building2 = $Building002
@onready var Building3 = $Building003
@onready var Building4=$Building004
@onready var Building5=$Building005
@onready var Building6=$Building006
@onready var Building7=$Building007
@onready var Building8=$Building008
func _ready():
	for button in [Building1, Building2, Building3,Building4,Building5,Building6,Building7,Building8]:
		button.building_pressed.connect(_on_building_pressed)

func _on_building_pressed(building_name):
	emit_signal("building_pressed", building_name)
	
