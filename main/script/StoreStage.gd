extends Node

signal harvest_updated
var harvest_data := {"carrot":0,
					"cabbage":0,
					"beet":0,
					"tomato":0,
					"corn":0,
					"pumpkin":0,
					"onion":0,
					"broccoli":0,
					"cat":0}  # 儲存每種作物的收成量，例如 {"tomato": 3, "cabbage": 1}

func reset():
	harvest_data = {"carrot":0,
					"cabbage":0,
					"beet":0,
					"tomato":0,
					"corn":0,
					"pumpkin":0,
					"onion":0,
					"broccoli":0,
					"cat":0}

func add_crop(crop_name: String, amount: int = 1):
	if harvest_data.has(crop_name):
		harvest_data[crop_name] += amount
		emit_signal("harvest_updated")
	else:
		harvest_data[crop_name] = amount
		emit_signal("harvest_updated")
	print("✅ 收成 ", crop_name, " x", amount, "（目前總數：", harvest_data[crop_name], "）")


func get_crop_count(crop_name: String) -> int:
	return harvest_data.get(crop_name, 0)
