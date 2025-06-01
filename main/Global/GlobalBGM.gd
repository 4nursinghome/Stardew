extends Node

var bgm_player: AudioStreamPlayer

var bgm_tracks := {
	#"NoticeItem_control": preload("res://assets/Notice_main.mp3"),
	#"Task_control": preload("res://assets/task_page.mp3"),
	#"Jokes_control": preload("res://assets/joke_page.mp3"),
	#"StoreRoom_control": preload("res://assets/storeroom_page.mp3")
}

func _ready():
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)

func play_bgm_for(page: String):
	if bgm_tracks.has(page):
		bgm_player.stop()
		bgm_player.stream = bgm_tracks[page]
		bgm_player.play()
	else:
		print("⚠️ 無對應 BGM：", page)
