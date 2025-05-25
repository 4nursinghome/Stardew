extends CanvasLayer

@onready var backgrounds = [
	get_node("background/background001"),
]

@onready var icon_farm = $bottom_ui/farm
@onready var icon_board = $bottom_ui/missingboard
@onready var icon_skill = $bottom_ui/skill
@onready var coin_label = $coin_ui/Label
@onready var heart_timer = $Timer

@onready var hearts = [
	get_node("heart_ui/heart001"),
	get_node("heart_ui/heart002"),
	get_node("heart_ui/heart003"),
	get_node("heart_ui/heart004"),
	get_node("heart_ui/heart005")
]

var current_background_index = 0
var coin_count = 0
var heart_count = 5  # 初始 5 顆心

func _ready():
	icon_farm.pressed.connect(_on_icon_farm_pressed)
	icon_board.pressed.connect(_on_icon_board_pressed)
	icon_skill.pressed.connect(_on_icon_skill_pressed)
	heart_timer.timeout.connect(_on_heart_timer_timeout)
	update_ui()

func _on_icon_farm_pressed():
	get_tree().change_scene_to_file("res://farm_page.tscn")

func _on_icon_board_pressed():
	get_tree().change_scene_to_file("res://missing_board_page.tscn")

func _on_icon_skill_pressed():
	get_tree().change_scene_to_file("res://skill_page.tscn")

func switch_background():
	for bg in backgrounds:
		bg.visible = false
	current_background_index = (current_background_index + 1) % backgrounds.size()
	backgrounds[current_background_index].visible = true

func update_ui():
	coin_label.text = str(coin_count)
	for i in range(hearts.size()):
		if hearts[i]:
			hearts[i].visible = i < heart_count

func _on_heart_timer_timeout():
	heart_count = max(0, heart_count - 1)
	update_ui()
