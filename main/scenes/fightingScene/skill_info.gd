extends Control
# -- 對話資料

@onready var playerStats=$Player.SkillStats.gethealth()
var dialogue_lines = [
	{"name": "hello", "text":playerStats },
]

var current_index := 0

@onready var skillName = $Panel/skillName
@onready var skillStatsInfo = $Panel/skillStatsInfo

func _ready():
	show_line(current_index)

func show_line(i: int):
	var line = dialogue_lines[i]
	skillName.text = line.text
	skillStatsInfo.text = line.name

func upgrade_pressed():
	end_skillInfo()
	
func cancel_pressed():
	end_skillInfo()

func end_skillInfo():
	hide()
	# 或 emit_signal("dialogue_finished") 看你要做什麼
