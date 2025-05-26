extends Control
signal request_switch_to(page_name: String)

var task_pool_basic = [
	{"target": "carrot", "required": 1, "reward": 2},
	{"target": "carrot", "required": 2, "reward": 4},
	{"target": "carrot", "required": 3, "reward": 6},
	{"target": "carrot", "required": 4, "reward": 8},
	{"target": "carrot", "required": 5, "reward": 10},
	{"target": "carrot", "required": 6, "reward": 12},
	{"target": "carrot", "required": 7, "reward": 14},
	{"target": "carrot", "required": 8, "reward": 16},
	{"target": "carrot", "required": 9, "reward": 18},
	{"target": "carrot", "required": 10, "reward": 20},
	{"target": "cabbage", "required": 1, "reward": 3},
	{"target": "cabbage", "required": 2, "reward": 6},
	{"target": "cabbage", "required": 3, "reward": 9},
	{"target": "cabbage", "required": 4, "reward": 12},
	{"target": "cabbage", "required": 5, "reward": 15},
	{"target": "cabbage", "required": 6, "reward": 18},
	{"target": "cabbage", "required": 7, "reward": 21},
	{"target": "cabbage", "required": 8, "reward": 24},
	{"target": "cabbage", "required": 9, "reward": 27},
	{"target": "beet", "required": 1, "reward": 4},
	{"target": "beet", "required": 2, "reward": 8},
	{"target": "beet", "required": 3, "reward": 12},
	{"target": "beet", "required": 4, "reward": 16},
	{"target": "beet", "required": 5, "reward": 20},
	{"target": "beet", "required": 6, "reward": 24},
	{"target": "beet", "required": 7, "reward": 28},
	{"target": "beet", "required": 8, "reward": 32}
]

var task_pool_advanced = [
	{"target": "carrot", "required": 1, "reward": 2},
	{"target": "carrot", "required": 2, "reward": 4},
	{"target": "carrot", "required": 3, "reward": 6},
	{"target": "cabbage", "required": 1, "reward": 3},
	{"target": "cabbage", "required": 2, "reward": 6},
	{"target": "cabbage", "required": 3, "reward": 9},
	{"target": "beet", "required": 1, "reward": 4},
	{"target": "beet", "required": 2, "reward": 8},
	{"target": "beet", "required": 3, "reward": 12},
	{"target": "tomato", "required": 1, "reward": 5},
	{"target": "tomato", "required": 2, "reward": 10},
	{"target": "tomato", "required": 3, "reward": 15},
	{"target": "tomato", "required": 4, "reward": 20},
	{"target": "tomato", "required": 5, "reward": 25},
	{"target": "corn", "required": 1, "reward": 6},
	{"target": "corn", "required": 2, "reward": 12},
	{"target": "corn", "required": 3, "reward": 18},
	{"target": "corn", "required": 4, "reward": 24},
	{"target": "pumpkin", "required": 1, "reward": 7},
	{"target": "pumpkin", "required": 2, "reward": 14},
	{"target": "pumpkin", "required": 3, "reward": 21},
	{"target": "onion", "required": 1, "reward": 8},
	{"target": "onion", "required": 2, "reward": 16},
	{"target": "broccoli", "required": 1, "reward": 9},
	{"target": "cat", "required": 1, "reward": 10}
]

var selected_tasks = []

func _ready():
	randomize()
	selected_tasks = []

	for i in range(3):
		generate_new_task(i)

	_update_coin_display()
	update_task_requirements()
	set_process(true)

	$TextureButton.pressed.connect(func(): _on_claim_pressed(0))
	$TextureButton2.pressed.connect(func(): _on_claim_pressed(1))
	$TextureButton3.pressed.connect(func(): _on_claim_pressed(2))

func _process(delta):
	update_task_requirements()

func _enter_tree():
	update_task_requirements()

func generate_new_task(index: int):
	var unlocked = StoreStage.harvest_data.keys()

	# 蝚� 0 隞餃�嗵鍂 basic嚗𤤿洵 1,2 隞餃�嗵鍂 advanced
	var task_pool = task_pool_basic
	if index == 1 or index == 2:
		task_pool = task_pool_advanced
		
	var available = task_pool.filter(func(t):
		return unlocked.has(t["target"])
	)

	var task_node = get_node("Task_%d" % (index + 1))

	if available.is_empty():
		task_node.get_node("Label").text = "No more tasks"
		task_node.get_node("Req_Label").text = ""
		task_node.get_node("Reward_Label").text = ""
		if selected_tasks.size() <= index:
			selected_tasks.append({})
		else:
			selected_tasks[index] = {}
		return

	var new_task = available[randi() % available.size()]
	new_task["title"] = "%d %s" % [new_task["required"], new_task["target"].capitalize()]
	new_task["claimed"] = false

	if selected_tasks.size() <= index:
		selected_tasks.append(new_task)
	else:
		selected_tasks[index] = new_task

	var owned = StoreStage.harvest_data.get(new_task["target"], 0)
	task_node.get_node("Label").text = new_task["title"]
	task_node.get_node("Req_Label").text = "%d / %d" % [owned, new_task["required"]]
	task_node.get_node("Reward_Label").text = "Coin x%d" % new_task["reward"]

func _on_claim_pressed(index: int):
	if index >= selected_tasks.size():
		return

	var task = selected_tasks[index]
	if task.is_empty():
		return

	var task_node = get_node("Task_%d" % (index + 1))

	if task.get("claimed", false):
		task_node.get_node("Req_Label").text = "Completed"
		return

	var owned = StoreStage.harvest_data.get(task["target"], 0)
	if owned >= task["required"]:
		StoreStage.harvest_data[task["target"]] -= task["required"]
		GlobalProperty.Property["Coin"] += task["reward"]
		task["claimed"] = true
		print("���� Task completed: ", task["title"], " �� Coins +", task["reward"])
		_update_coin_display()
		generate_new_task(index)
	else:
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]
		print("��� Not enough: ", owned, "/", task["required"])

func update_task_requirements():
	for i in range(selected_tasks.size()):
		var task = selected_tasks[i]
		if task.is_empty():
			continue
		var task_node = get_node("Task_%d" % (i + 1))
		var owned = StoreStage.harvest_data.get(task["target"], 0)
		task_node.get_node("Req_Label").text = "%d / %d" % [owned, task["required"]]

func _update_coin_display():
	$Coin/Label.text = str(int(GlobalProperty.Property["Coin"]))

func _on_back_button_pressed():
	emit_signal("request_switch_to", "NoticeItem_control")
