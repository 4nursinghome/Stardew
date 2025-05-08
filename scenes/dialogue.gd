extends Control

# -- 對話資料
var dialogue_lines = [
	{"name": "farmer", "text": "hello"},
	{"name": "you", "text": "who are you"},
	{"name": "farmer", "text": "I am Donald Trump, and I am gonna put a 1064% tariff on you."},
	{"name": "you", "text": "I don't care, I don't even pays tax."},
	{"name": "farmer", "text": "It's you! The legendary tax invader, I am going to kill you and make america great again!"},
	{"name": "farmer", "text": "(ﾒ` ﾛ ´)︻デ==════"}
]

var current_index := 0

@onready var text_label = $Panel/Text
@onready var name_label = $Panel/Name

func _ready():
	show_line(current_index)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		next_line()

func next_line():
	current_index += 1
	if current_index < dialogue_lines.size():
		show_line(current_index)
	else:
		end_dialogue()

func show_line(i: int):
	var line = dialogue_lines[i]
	text_label.text = line.text
	name_label.text = line.name

func end_dialogue():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	# 或 emit_signal("dialogue_finished") 看你要做什麼
