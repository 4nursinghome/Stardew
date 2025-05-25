extends Node

@onready var bgm_player: AudioStreamPlayer = $BGMPlayer

func _ready():
	if bgm_player.stream:
		bgm_player.play()
	else:
		push_error("ERROR")
