extends Node2D
signal change_scene(number:String)
signal change_enemy(number:String)
signal openDialogue
signal fightEnd
@onready var BGM=$Bgm
@onready var farmCam=$farm/Camera2D
@onready var mainCam=$mainPage/Camera2D
@onready var main=$mainPage
@onready var farm=$farm
@onready var fightCam=$fight/Camera2D
@onready var win=$fight/win
@onready var game_over=$fight/GameOver
@onready var fight=$fight
@onready var board=$Main_contorl
@onready var storageBoardCam=$Main_contorl/StoreRoom_Camera2D
@onready var noticeBoardCam=$Main_contorl/NoticeItem_Camera2D
@onready var farmPagebutton=$farm/farmButton
@onready var skill=$skillUpgradePlacement
@onready var skillCam=$skillUpgradePlacement/Camera2D
var current_scene=""
func _ready():
	call_deferred("setup_signals")
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		GlobalSfx.play_click()
func setup_signals():
	fight.button_W_L_pressed.connect(switch_Cam)
	main.mainPage_pressed.connect(switch_Cam)
	main.building_pressed.connect(switch_Cam)
	farmPagebutton.home_pressed.connect(switch_Cam)
	board.request_switch_to_TOP_CONTROL.connect(switch_Cam)
	skill.home_pressed.connect(switch_Cam)
var _new_fight


func reset_fight():
	if is_instance_valid(fight):
		fight.queue_free()
	await get_tree().process_frame

	_new_fight = preload("res://scenes/fightingScene/scenes/fight.tscn").instantiate()
	_new_fight.name = "fight"
	_new_fight.active = false  # 確保還沒開始
	add_child(_new_fight)
	move_child(_new_fight, get_children().find(main) + 3)
	await get_tree().process_frame
	fight = _new_fight
	win = _new_fight.get_node("win")
	game_over = _new_fight.get_node("GameOver")
	fightCam = _new_fight.get_node("Camera2D")
	fight.button_W_L_pressed.connect(switch_Cam)
	fightCam.enabled = false
#
	#print("🎥 fightCam 確認抓到：", fightCam)
	#print("🎥 是否 Camera2D：", fightCam is Camera2D)
	#print("🎥 current 狀態：", fightCam.enabled)
	#print("📌 fight 加進的父節點是：", _new_fight.get_parent().name)

func start_fight():
	if fight:
		fight.start() 
func switch_Cam(button_name):
	noticeBoardCam.enabled=false
	storageBoardCam.enabled=true
	farmCam.enabled = false
	mainCam.enabled = false
	skillCam.enabled=false
	fightCam.enabled = false
	match button_name: 
		"skill":
			fightCam.enabled = false
			skillCam.enabled=true
			skillCam.make_current()
		"farm":
			print("ggggggggg")
			noticeBoardCam.enabled=false
			farmCam.enabled = true
			farmCam.make_current() 
		"board_to_home":
			print("qqqqqqq")
			storageBoardCam.enabled=false
			noticeBoardCam.enabled=false
			mainCam.enabled=true
			mainCam.make_current()
		"board_to_farm":
			storageBoardCam.enabled=false
			farmCam.enabled=true
		"home":
			reset_fight()
			BGM.homeBGM()
			emit_signal("fightEnd")
			mainCam.enabled = true
			mainCam.make_current() 
			
			#print("🎥 mainCam 確認抓到：", mainCam)
			#print("🎥 是否 Camera2D：", mainCam is Camera2D)
			#print("🎥 current 狀態：", mainCam.enabled)
			#print("🎥 fight current 狀態：", fightCam.enabled)
			   ## ✅ 切換控制權 
			#print("🎥 Current camera node is: ", get_viewport().get_camera_2d())
		"board":
			print("board")
			
			noticeBoardCam.enabled=true
			noticeBoardCam.make_current()
		"storage":
			print("storage")
			storageBoardCam.enabled=true
			storageBoardCam.make_current()
		"farm_home":
			mainCam.enabled=true
			mainCam.make_current()
		"reset_fight":
			
			await reset_fight()
			fightCam.enabled=true
			fightCam.make_current()
		"fight":
			print("why????")
			await reset_fight()
			emit_signal("openDialogue")
			emit_signal("change_scene",current_scene)
			emit_signal("change_enemy",current_scene)
			fightCam.enabled=true
			fightCam.make_current()
		_:
			print("ndywd")
			if button_name in ["2", "3", "4", "5","6", "7", "8","9"]:
				print("mmmsdsd")
				BGM.fightingBGM()
				skillStats.next_level(int(button_name))
				print("efye  ",skillStats.levelGetter())
				emit_signal("openDialogue")
				noticeBoardCam.enabled=false
				fightCam.enabled = true
				fightCam.make_current()
				fight.dialog_end.connect(start_fight)
				if  fight.dialog_end.is_connected(start_fight):
					print("start")
					current_scene=button_name
					emit_signal("change_scene",button_name)
					emit_signal("change_enemy",button_name)
					
