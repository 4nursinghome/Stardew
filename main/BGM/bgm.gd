extends Node
@onready var home: AudioStreamPlayer = null
@onready var fight: AudioStreamPlayer = null

func _ready():
	await get_tree().process_frame
	home = get_node_or_null("home")
	fight = get_node_or_null("fight")
	
	if home and fight:
		print("✅ Bgm ready 完成並連結 home/fight")
		homeBGM()
	else:
		push_error("❌ 無法連結 BGM 子節點")


func homeBGM():
	if home and fight:
		fight.stop()
		home.stream.loop = true
		home.play()

func fightingBGM():
		home.stop()
		fight.stream.loop = true
		fight.play()
