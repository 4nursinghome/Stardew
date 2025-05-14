extends Node

@onready var bgm_player: AudioStreamPlayer = $BGMPlayer

func _ready():
	# 如果你沒勾 Autoplay，也可以靠這段啟動
	if bgm_player.stream:
		bgm_player.play()
	else:
		push_error("GlobalBGM：請先在 BGMPlayer.stream 指定音樂檔！")
