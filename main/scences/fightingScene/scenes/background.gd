extends Node2D

var background_name: String = "background"

func _ready():
	var main = get_tree().current_scene
	if main.has_signal("change_scene"):
		main.change_scene.connect(change_background)

func change_background(number):
	background_name = "background" + str(number)  # ← 修正這行

	for node in get_children():
		if node is Sprite2D:
			node.visible = (node.name == background_name)
