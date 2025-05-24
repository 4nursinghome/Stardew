extends Area2D

@onready var harvest_manager = get_node("/root/world/HarvestManager")

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		for child in get_parent().get_children():
			if child is Sprite2D and child.has_method("reset_crop") and child.is_ready:
				var crop_name := child.name.to_lower()

				# 🔔 顯示提示通知
				if harvest_manager:
					harvest_manager.show_popup(crop_name)

				# 🧺 記錄到倉儲
				StoreStage.add_crop(crop_name)

				# 🧹 重置作物
				child.reset_crop()
				break
