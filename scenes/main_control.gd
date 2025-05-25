extends Control
signal request_switch_to_TOP_CONTROL(page_name: String)
func _ready():
	print("✅ Main_control 啟動（Camera 模式）")

	$NoticeItem_control.request_switch_to.connect(_on_request_switch_to)
	$Task_control.request_switch_to.connect(_on_request_switch_to)
	$Jokes_control.request_switch_to.connect(_on_request_switch_to)
	$StoreRoom_contorl.request_switch_to.connect(_on_request_switch_to)

	_show_camera("StoreRoom_Camera2D")
	#_show_camera("Task_Camera2D")

func _on_request_switch_to(target: String) -> void:
	match target:
		"Task_control":
			print("🔁 切換到任務頁面 CameraTask")
			_show_camera("Task_Camera2D")
		"Jokes_control":
			print("🔁 切換到笑話頁面 CameraJokes")
			_show_camera("Jokes_Camera2D")
		"StoreRoom_control":
			print("🔁 切換到倉庫頁面 CameraStoreRoom")
			_show_camera("StoreRoom_Camera2D")
		"NoticeItem_control":
			print("🔁 回到首頁 CameraNotice")
			_show_camera("NoticeItem_Camera2D")
		"Home":
			emit_signal("request_switch_to_TOP_CONTROL","home")
			print("這裡要切換到主頁面")
			get_tree().quit()
		"Farm_control":
			emit_signal("request_switch_to_TOP_CONTROL","farm")
			print("🔁這裡要切換到Farm頁面")
		_:
			print("⚠️ 未知指令：", target)

func _show_camera(camera_name: String) -> void:
	for node in get_children():
		if node is Camera2D:
			node.enabled = (node.name == camera_name)
