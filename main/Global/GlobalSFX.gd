extends Node
var click_player: AudioStreamPlayer
func _ready():
	click_player = AudioStreamPlayer.new()
	add_child(click_player)
	click_player.stream = load("res://BGM/bubble.mp3")  # 改成你的音效路徑

func play_click():
	if click_player:
		click_player.play()
