extends Node

var harvest_data := {}  # 儲存每種作物的收成量，例如 {"tomato": 3, "cabbage": 1}

func add_crop(crop_name: String, amount: int = 1):
	if harvest_data.has(crop_name):
		harvest_data[crop_name] += amount
	else:
		harvest_data[crop_name] = amount
	print("✅ 收成 ", crop_name, " x", amount, "（目前總數：", harvest_data[crop_name], "）")

func get_crop_count(crop_name: String) -> int:
	return harvest_data.get(crop_name, 0)
