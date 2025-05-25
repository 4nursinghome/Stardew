extends Node

var harvest_data := {"carrot":999,
					"cabbage":999,
					"beet":999,
					"tomato":999,
					"corn":999,
					"pumpkin":999,
					"onion":999,
					"broccoli":999,
					"cat":999}  # 儲存每種作物的收成量，例如 {"tomato": 3, "cabbage": 1}

func add_crop(crop_name: String, amount: int = 1):
	if harvest_data.has(crop_name):
		harvest_data[crop_name] += amount
	else:
		harvest_data[crop_name] = amount
	print("✅ harvest ", crop_name, " x", amount, "（Total：", harvest_data[crop_name], "）")

func get_crop_count(crop_name: String) -> int:
	return harvest_data.get(crop_name, 0)
