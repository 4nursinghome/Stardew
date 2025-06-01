extends Node2D

@onready var label = $DialogueLayer/Panel/Label
@onready var dialogue_layer = $DialogueLayer

var dialogues = [
	"你好，歡迎來到我們的世界。",
	"這裡是你的第一個任務地點。",
	"請跟著指示完成教學。"
]

var dialogue_index = 0

func _ready():
	# 延遲執行，確保所有節點都已加入場景樹
	call_deferred("show_next_dialogue")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		show_next_dialogue()

func show_next_dialogue():
	# 防呆檢查，確保節點存在
	if label == null or dialogue_layer == null:
		print("❌ 錯誤：label 或 dialogue_layer 尚未正確初始化")
		return

	if dialogue_index < dialogues.size():
		label.text = dialogues[dialogue_index]
		dialogue_index += 1
	else:
		dialogue_layer.hide()  # 對話結束後隱藏
