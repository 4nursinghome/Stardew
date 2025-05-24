extends Control

const PLANTS = ["carrot","tomato","onion","broccoli","beet","pumpkin","corn","cabbage","cat"]

func _ready():
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
