extends Area2D

@export var crop_nodes: Array[NodePath] = []
@export var unlock_cost: int = 30  # 每塊黑土地的解鎖金額，可自訂

var unlocked := false
@onready var price_label = $PriceLabel

func _ready():
	price_label.text = str(unlock_cost)
	price_label.visible = not unlocked  # 只在未解鎖時顯示

	for path in crop_nodes:
		if has_node(path):
			var crop_node = get_node(path)
			if crop_node:
				for child in crop_node.get_children():
					if child is Sprite2D or child is GPUParticles2D or child is CPUParticles2D:
						child.hide()
						if child is GPUParticles2D or child is CPUParticles2D:
							child.emitting = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not unlocked:
			# 嘗試扣除金幣，成功才解鎖
			if GlobalProperty.spend_coins(unlock_cost):
				unlocked = true
				price_label.hide()

				for path in crop_nodes:
					if has_node(path):
						var crop_node = get_node(path)
						if crop_node:
							for child in crop_node.get_children():
								if child is Sprite2D or child is GPUParticles2D or child is CPUParticles2D:
									child.show()
									if child is Sprite2D:
										if child.has_method("set_frame"):
											child.set_frame(0)
										elif child.has_meta("frame"):
											child.frame = 0
									if child is GPUParticles2D or child is CPUParticles2D:
										child.emitting = false

							# 通用啟動作物成長
							for child in crop_node.get_children():
								if child is Sprite2D and child.has_method("_start_growth"):
									child._start_growth()

				$lock.queue_free()
				$coin2.queue_free()
				queue_free()
			else:
				print("❌ 金幣不足，無法解鎖")
