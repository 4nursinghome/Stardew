extends Node2D

@onready var dialogue_box = $Control/Panel
@onready var name_label = $Control/Panel/LabelName
@onready var dialogue_label = $Control/Panel/Label

var dialogues = [
	{ "speaker": "Player", "line": "This place feels larger than the last one.\nAnd a lot livelier." },
	{ "speaker": "Dystopia", "line": "As more residents arrived, \nI needed extra hands. \nThis is where I hired our first caregivers." },
	{ "speaker": "Player", "line": "Caregivers? \nI thought you took care of everyone yourself." },
	{ "speaker": "Dystopia", "line": "I still do, \nbut there are simply too many now. \nI had to build a system to make sure \nno one is forgotten." },
	{ "speaker": "", "line": "(A distant bell chimes...)" },
	{ "speaker": "Player", "line": "What was that sound just now?" },
	{ "speaker": "Dystopia", "line": "The schedule bell. \nFrom today, we have timetables: \nmeals, activities, rest. \nEverything runs more smoothly now." },
	{ "speaker": "Player", "line": "Sounds... \nA bit like a school." },
	{ "speaker": "Dystopia", "line": "Not a school, and not a prison. \nJust a way to help them live better, \nwith consistency and care." },
	{ "speaker": "Player", "line": "But it’s still beautiful here. \nThe fish pond, the lanterns, the garden paths. \nIt feels warm." },
	{ "speaker": "Dystopia", "line": "I never wanted this place to lose its warmth. \nEven with structure, they should feel alive.\nNot just stored away." },
	{ "speaker": "Player", "line": "You still remember \nwhat the first home was like." },
	{ "speaker": "Dystopia", "line": "How could I ever forget?" }
]

var dialogue_index = 0
var is_typing = true
var typing_speed = 0.04

func _ready():
	dialogue_box.gui_input.connect(_on_dialogue_box_clicked)
	show_next_dialogue()

func _on_dialogue_box_clicked(event):
	if event is InputEventMouseButton and event.pressed:
		if is_typing:
			var current = dialogues[dialogue_index]
			dialogue_label.text = current["line"]
			is_typing = false
		else:
			show_next_dialogue()

func show_next_dialogue():
	if dialogue_index < dialogues.size():
		var current = dialogues[dialogue_index]
		name_label.text = current["speaker"]
		set_text_color(current["speaker"])
		dialogue_label.text = ""
		await type_text(current["line"])
		dialogue_index += 1
	else:
		dialogue_box.hide()

func type_text(text: String) -> void:
	is_typing = true
	var char_index = 0
	dialogue_label.text = ""

	while char_index < text.length() and is_typing:
		dialogue_label.text += text[char_index]
		char_index += 1
		await get_tree().create_timer(typing_speed).timeout

	if not is_typing:
		dialogue_label.text = text

	is_typing = false

func set_text_color(speaker: String) -> void:
	match speaker:
		"Dystopia":
			dialogue_label.modulate = Color(0.85, 0.75, 0.3)
		"Player":
			dialogue_label.modulate = Color(0.8, 0.8, 0.3)
		_:
			dialogue_label.modulate = Color(0.95, 0.9, 0.9)
