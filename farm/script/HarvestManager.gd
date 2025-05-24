extends Node

@export var popup_container: Node        # 指到右上角的提示容器（Control）
@export var sprite_frames: SpriteFrames  # 指到切好的 SpriteFrames（含作物圖）

# 對應作物名稱與 SpriteFrames 的 frame 索引
var icon_index := {
	"carrot": 0,
	"cabbage": 1,
	"beet": 2,
	"tomato": 3,
	"corn": 4,
	"pumpkin": 5,
	"onion": 6,
	"brocoli": 7,
	"cat": 8
}

var active_popups := {}  # 用來記錄目前有哪些作物的提示還在畫面上

func show_popup(crop: String):
	if not icon_index.has(crop):
		print("❌ 無對應 icon 的作物：", crop)
		return

	var tex = sprite_frames.get_frame_texture("plants", icon_index[crop])

	if active_popups.has(crop):
		active_popups[crop].add_stack()
	else:
		var popup = preload("res://scenes/HarvestNotifier.tscn").instantiate()
		
		popup_container.add_child(popup)         
		await get_tree().process_frame          
		popup.setup(crop, tex)                   
		print("🔔 產生提示框：", crop)

		active_popups[crop] = popup
		await popup.tree_exited
		active_popups.erase(crop)
