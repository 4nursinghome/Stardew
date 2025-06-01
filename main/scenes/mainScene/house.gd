extends Control
signal building_pressed(building_name)

@onready var Building1 = $Building002
@onready var Building2 = $Building003
@onready var Building3 = $Building004
@onready var Building4=$Building005
@onready var Building5=$Building006
@onready var Building6=$Building007
@onready var Building7=$Building008
@onready var Building8=$Building009
var nextBuliding:String
func _ready():
	for button in [Building1, Building2, Building3,Building4,Building5,Building6,Building7,Building8]:
		
		button.building_pressed.connect(_on_building_pressed)
	
	for button in [Building1, Building2, Building3,Building4,Building5,Building6,Building7]:
		button.nextShow.connect(showNextBuilding)
func _on_building_pressed(building_name):
	emit_signal("building_pressed", building_name)
	
func showNextBuilding(next):
	print("win lose test ",skillStats.WinorLose)
	if skillStats.WinorLose==true:
		for node in get_children():			
			var node_collision=node.get_node("CollisionShape2D")
			if node is Area2D and node.name == "Building00"+str(next):
				print("mask disable")
				var node_mask = node.get_node("mask")
				node_mask.visible = false
				print(next)
				node_collision.disabled=false
			else :
				node_collision.disabled=true
