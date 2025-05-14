extends Control

var all_tasks = [
	{
		"title": "繳交紅蘿蔔",
		"target": "carrot",
		"required": 3,
		"reward": {"Tomato": 2},
		"claimed": false
	},
	{
		"title": "繳交葡萄",
		"target": "Grape",
		"required": 5,
		"reward": {"corn": 1},
		"claimed": false
	},
	{
		"title": "繳交南瓜",
		"target": "Pumpkin",
		"required": 2,
		"reward": {"Cabbage": 3},
		"claimed": false
	},
	{
		"title": "拔起番茄",
		"target": "Tomato",
		"required": 4,
		"reward": {"Carrot": 1},
		"claimed": false
	}
]

var selected_tasks = []

func _ready():
	randomize()
	all_tasks.shuffle()
	selected_tasks = all_tasks.slice(0, 3)

	for i in range(3):
		var task_node = get_node("Task_%d" % (i + 1))
		var task = selected_tasks[i]
		var owned = GlobalInventory.inventory.get(task["target"], 0)

		task_node.get_node("Label").text = task["title"]
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]

		var reward_text = ""
		for reward_item in task["reward"]:
			reward_text += "%s x%d  " % [reward_item, task["reward"][reward_item]]
		task_node.get_node("Reward_Label").text = reward_text

	$TextureButton.pressed.connect(func(): _on_claim_pressed(0))
	$TextureButton2.pressed.connect(func(): _on_claim_pressed(1))
	$TextureButton3.pressed.connect(func(): _on_claim_pressed(2))

func _on_claim_pressed(index: int):
	var task = selected_tasks[index]
	var task_node = get_node("Task_%d" % (index + 1))
	if task["claimed"]:
		task_node.get_node("Req_Label").text = "已領取"
		return

	var owned = GlobalInventory.inventory.get(task["target"], 0)
	if owned >= task["required"]:
		GlobalInventory.inventory[task["target"]] -= task["required"]
		for reward_item in task["reward"]:
			GlobalInventory.inventory[reward_item] += task["reward"][reward_item]
		task["claimed"] = true
		task_node.get_node("Req_Label").text = "已完成"
		print("🎉 任務完成，獲得獎勵：", task["reward"])
	else:
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]
		print("❌ 條件未達成，目前持有：", owned, "/", task["required"])
