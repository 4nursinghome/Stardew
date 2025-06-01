extends Control
signal request_switch_to(page_name: String)

@onready var sort_menu: OptionButton = $SortMenu
@onready var joke_label: Label = $JokeLabel
@onready var back_button = $BackButton_pic 

var jokes := [
	{"key": "A", "title": "Algorithm", "text": "Q: Why did the algorithm go to therapy?\nA: It had trouble letting go of past iterations."},
	{"key": "C", "title": "Computer", "text": "Q: Why did the computer go to therapy?\nA: It had too many bytes from the past."},
	{"key": "H", "title": "Homework", "text": "Q: Why did the student eat his homework?\nA: The teacher said it was a piece of cake."},
	{"key": "M", "title": "Monitor", "text": "Q: Why was the monitor always calm?\nA: Because it had great resolution."},
	{"key": "N", "title": "Network", "text": "Q: Why don’t networks ever gossip?\nA: They prefer to keep things private."}
]

func _ready():
	sort_menu.add_item("Sort by Title A-Z")      # index 0
	sort_menu.add_item("Sort by Joke Length")    # index 1

	sort_menu.connect("item_selected", Callable(self, "_on_sort_selected"))
	back_button.pressed.connect(_on_back_button_pressed)

	_display_jokes(jokes)

func _on_sort_selected(index: int) -> void:
	var temp = jokes.duplicate()

	match index:
		0:
			temp.sort_custom(func(a, b): return a["title"] < b["title"])
		1:
			temp.sort_custom(func(a, b): return a["text"].length() < b["text"].length())

	_display_jokes(temp)

func _display_jokes(joke_list: Array) -> void:
	var output := ""
	for joke in joke_list:
		output += "[" + joke["title"] + "]\n" + joke["text"] + "\n\n"
	joke_label.text = output

func _on_back_button_pressed() -> void:
	print("🔙 Back 被按下")
	emit_signal("request_switch_to", "NoticeItem_control")
