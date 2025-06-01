extends Node

@export var popup_container: Node
@export var sprite_frames: SpriteFrames

var icon_index := {
	"carrot": 0, "cabbage": 1, "beet": 2, "tomato": 3,
	"corn": 4, "pumpkin": 5, "onion": 6, "brocoli": 7, "cat": 8
}

var current_crop := ""  # 記錄目前提示的是哪種作物
var current_popup: Control = null

func show_popup(crop: String):
	if not icon_index.has(crop):
		print("❌ 無對應 icon 的作物：", crop)
		return

	var tex = sprite_frames.get_frame_texture("plants", icon_index[crop])

	# 如果有現有提示框，且作物不同，就移除它
	if current_popup and is_instance_valid(current_popup):
		if crop != current_crop:
			current_popup.queue_free()
		else:
			# 同一作物就直接堆疊
			current_popup.add_stack()
			return

	# 產生新提示框
	var popup = preload("res://scenes/farmScene/HarvestNotifier.tscn").instantiate()
	popup_container.add_child(popup)
	await get_tree().process_frame

	popup.setup(tex)
	current_crop = crop
	current_popup = popup

	# 提示板消失時清除記錄
	popup.tree_exited.connect(func():
		if current_popup == popup:
			current_popup = null
			current_crop = ""
	)
