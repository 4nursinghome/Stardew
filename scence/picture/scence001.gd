extends Node2D

@onready var dialogue_box = $Control/Panel
@onready var name_label = $Control/Panel/LabelName
@onready var dialogue_label = $Control/Panel/Label

var dialogues = [
	{ "speaker": "Dystopia", "line": "Welcome to the House of Dawn." },
	{ "speaker": "Player", "line": "This place feels peaceful.\nWhy is it called that?" },
	{ "speaker": "Dystopia", "line": "It was my wife’s favorite time of day.\nJust after sunrise.\nThe light was perfect and gentle, \nlike her smile." },
	{ "speaker": "Player", "line": "Are they your family?" },
	{ "speaker": "Dystopia", "line": "Yes.\nMy wife and our son...\nThey’ve been gone for many years now." },
	{ "speaker": "Player", "line": "That’s why you built this place?" },
	{ "speaker": "Dystopia", "line": "I couldn’t change the past.\nBut I wanted to give others a place\nwhere they could finish their days in peace." }
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
			dialogue_label.modulate = Color(0.5, 0.4, 0.3)
		"Player":
			dialogue_label.modulate = Color(0.4, 0.4, 0.5)
		_:
			dialogue_label.modulate = Color(0.95, 0.9, 0.9)
