extends Control
signal request_switch_to(page_name: String)
var all_tasks = [
	{
		"title": "Submit carrots",
		"target": "carrot",
		"required": 3,
		"reward": 10,
		"claimed": false
	},
	{
		"title": "Submit corn",
		"target": "corn",
		"required": 5,
		"reward": 15,
		"claimed": false
	},
	{
		"title": "Submit pumpkin",
		"target": "pumpkin",
		"required": 2,
		"reward": 20,
		"claimed": false
	},
	{
		"title": "Subit tomatoes",
		"target": "tomato",
		"required": 4,
		"reward": 12,
		"claimed": false
	}
]

var selected_tasks = []

func _ready():
	load_game()
	randomize()
	all_tasks.shuffle()
	selected_tasks = all_tasks.slice(0, 3)

	for i in range(3):
		var task_node = get_node("Task_%d" % (i + 1))
		var task = selected_tasks[i]
		var owned = StoreStage.harvest_data.get(task["target"], 0)

		task_node.get_node("Label").text = task["title"]
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]
		task_node.get_node("Reward_Label").text = "Coin x%d" % task["reward"]

	_update_coin_display()

	$TextureButton.pressed.connect(func(): _on_claim_pressed(0))
	$TextureButton2.pressed.connect(func(): _on_claim_pressed(1))
	$TextureButton3.pressed.connect(func(): _on_claim_pressed(2))

func _on_claim_pressed(index: int):
	var task = selected_tasks[index]
	var task_node = get_node("Task_%d" % (index + 1))
	if task["claimed"]:
		task_node.get_node("Req_Label").text = "Completed"
		return

	var owned = StoreStage.harvest_data.get(task["target"], 0)
	if owned >= task["required"]:
		StoreStage.harvest_data[task["target"]] -= task["required"]
		GlobalProperty.Property["Coin"] += task["reward"]
		task["claimed"] = true
		task_node.get_node("Req_Label").text = "Completed"
		print("🎉 Complete the task and get gold coins：", task["reward"])
		save_game()
		_update_coin_display()
	else:
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]
		print("❌ Conditions not met, currently holding：", owned, "/", task["required"])

func _update_coin_display():
	$Coin/Label.text = str(GlobalProperty.Property["Coin"])

func save_game():
	var save_data = {
		"coin": GlobalProperty.Property["Coin"]
	}
	var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game():
	if FileAccess.file_exists("user://save_data.json"):
		var file = FileAccess.open("user://save_data.json", FileAccess.READ)
		var content = file.get_as_text()
		var save_data = JSON.parse_string(content)
		if save_data:
			GlobalProperty.Property["Coin"] = save_data.get("coin", 10)
		file.close()


func _on_back_button_pressed() -> void:
	print("back在基層被按下")
	emit_signal("request_switch_to","NoticeItem_control")
	# Replace with function body.
