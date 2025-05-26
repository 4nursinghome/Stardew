extends Control
signal request_switch_to(page_name: String)

const PLANTS = ["carrot","tomato","onion","brocoli","beet","pumpkin","corn","cabbage","cat"]

func update_plant_slots():
	for plant in PLANTS:
		var slot_node = $NineGrid.get_node_or_null(plant.capitalize() + "Slot")
		if slot_node:
			var amount = StoreStage.harvest_data.get(plant, 0)
			var img = slot_node.get_node("TextureRect")
			var label = slot_node.get_node("Label")

			if amount >= 1:
				slot_node.visible = true
				label.text = "x" + str(amount)
			else:
				slot_node.visible = false

func _ready():
	StoreStage.connect("harvest_updated", Callable(self, "update_plant_slots"))


func _on_back_button_pressed() -> void:
	print("back在基層被按下")
	emit_signal("request_switch_to","NoticeItem_control")
	# Replace with function body.
