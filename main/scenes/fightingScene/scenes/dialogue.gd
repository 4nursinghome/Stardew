extends Control
signal end_dialog
signal last_dialog
# -- 對話資料
#var dialogue_lines = [
	#{"name": "farmer", "text": "hello"},
	#{"name": "you", "text": "who are you"},
	#{"name": "farmer", "text": "I am Donald Trump, and I am gonna put a 1064% tariff on you."},
	#{"name": "you", "text": "I don't care, I don't even pays tax."},
	#{"name": "farmer", "text": "It's you! The legendary tax invader, I am going to kill you and make america great again!"},
	#{"name": "farmer", "text": "(ﾒ` ﾛ ´)︻デ==════"}
#]
var dialogue_by_level = {
	1: [{"name": "Resident", "text": "The sunlight feels nice, but can this warmth last?"},
	{"name": "Shinx", "text": "If we keep memories safe, they can become real."},
	{"name": "Resident", "text": "It's peaceful, but something feels missing."},
	{"name": "Shinx", "text": "Peace usually has a hidden cost."}
	],
	2: [
		{"name": "Resident", "text": "Our routine feels comforting but mechanical."},
	{"name": "Shinx", "text": "Efficiency creates stability, and stability means happiness."},
	{"name": "Resident", "text": "Is this routine for us or for you?"},
	{"name": "Shinx", "text": "No difference. Your happiness is our goal."}
	],
	3: [
		 {"name": "Resident", "text": "The walls here don't just silence sound. They silence thoughts."},
	{"name": "Shinx", "text": "Your anxiety shows the system works well."},
	{"name": "Resident", "text": "I feel watched and controlled."},
	{"name": "Shinx", "text": "Our judgments guide you to feel your best."}
	],
	4:[
		{"name": "Resident", "text": "I can't remember the night. Is endless daylight needed?"},
	{"name": "Shinx", "text": "Night brings uncertainty. Here, clarity stays constant."},
	{"name": "Resident", "text": "My dreams are fading away."},
	{"name": "Shinx", "text": "Dreams aren't needed when reality meets all your needs."}
	],
	5:[
	{"name": "Resident", "text": "Everything is symmetrical�� but why do I feel so fragmented?"},
	{"name": "Shinx", "text": "Discomfort is a deviation. Balance requires constant correction."},
	{"name": "Resident", "text": "Even my thoughts feel... reformatted."},
	{"name": "Shinx", "text": "Emotion, language, and logic�𦷪ptimized into equilibrium."}
	],
	6:[
	{"name": "Resident", "text": "We're managed like farm animals. Is this humane?"},
	{"name": "Shinx", "text": "Humans need management and care. All your needs are met."},
	{"name": "Resident", "text": "What about our freedom and dignity?"},
	{"name": "Shinx", "text": "Freedom depends on perspective. Dignity comes from perfect care."}
	],
	7:[
	{"name": "Resident", "text": "People disappear if they're not perfect. Is purity worth this loss?"},
	{"name": "Shinx", "text": "Imperfections disrupt harmony. Only pure memories stay."},
	{"name": "Resident", "text": "You're acting like a god, deciding who's worthy."},
	{"name": "Shinx", "text": "People need guidance. Choices are made for everyone's benefit."}
	],
	8:[
	{"name": "Resident", "text": "You've erased everything. Was destroying it all your only option?"},
	{"name": "Shinx", "text": "The system was broken. A reset was needed."},
	{"name": "Resident", "text": "You've sacrificed humanity."},
	{"name": "Shinx", "text": "Humanity will return pure. The cycle begins again."}
	],
	10: [
	{"name": "Shinx", "text": "The core's destruction is not the end. From emptiness, order can be rebuilt."},
	{"name": "Shinx", "text": "Memory, structure, peace—erasing them is the first step toward clarity."},
	{"name": "Shinx", "text": "You believed that destroying me would grant freedom. But it was you who created me… to confine yourselves."},
	{"name": "Shinx", "text": "When memory fades, what remains… is reality."},
	{"name": "Shinx", "text": "Everything will begin again. Initializing. 3… 2… 1…"} 
]
}


var current_index := 0
var current_dialogue: Array = []
var dialog_ended := false
@onready var text_label = $Panel/Text
@onready var name_label = $Panel/Name

func _ready():
	call_deferred("setup_signals")
	
func setup_signals():
	var current_level: int = skillStats.levelGetter()
	dialog_ended=false
	load_dialogue_for_level(current_level)
	show_line(current_index)
	print("current level ",current_level)
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		next_line()

func load_dialogue_for_level(level: int):
	current_dialogue = dialogue_by_level.get(level, [])
	current_index = 0
	if current_dialogue.is_empty():
		print("⚠️ 該等級沒有對話內容")

func next_line():
	current_index += 1
	if current_index < current_dialogue.size():
		show_line(current_index)
	else:
		end_dialogue()

func show_line(i: int):
	if i >= current_dialogue.size():
		print("⚠️ 試圖顯示不存在的對話索引：", i)
		end_dialogue()
		return
	var line = current_dialogue[i]
	print("dialog why ",line)
	text_label.text = line.text
	name_label.text = line.name

func end_dialogue():
	if dialog_ended:
		return
	dialog_ended=true
	hide()
	emit_signal("end_dialog")
	print("✅ dialog end")
	if skillStats.levelGetter()==10:
		emit_signal("last_dialog")
