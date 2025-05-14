extends Control

const PLANTS = ["Carrot","Tomato","Onion","Broccoli","Beet","Pumpkin","Corn","Cabbage"]

func _ready():
	for plant in PLANTS:
		var slot_node = $NineGrid.get_node_or_null(plant.capitalize() + "Slot")
		if slot_node:
			var amount = GlobalInventory.inventory.get(plant, 0)
			var img = slot_node.get_node("TextureRect")
			var label = slot_node.get_node("Label")
			
			if amount >= 1:
				slot_node.visible = true
				label.text = "x" + str(amount)
			else:
				slot_node.visible = false
