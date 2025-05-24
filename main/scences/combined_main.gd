extends Node2D
@onready var farmCam=$farm/Camera2D
@onready var mainCam=$mainPage/Camera2D
@onready var main=$mainPage
@onready var farm=$farm
@onready var fightCam=$main/Camera2D
@onready var win=$main/win
@onready var farmPagebutton=$farm/farmButton
func _ready():
	call_deferred("setup_signals")
func spawn_win_scene():
	var win_scene = preload("res://scenes/fightingScene/scenes/win.tscn").instantiate()
	main.add_child(win_scene)  # 或 add_child(win_scene)，看你要放在哪裡
	win_scene.back_to_main_pressed.connect(switch_Cam)
func setup_signals():
	main.mainPage_pressed.connect(switch_Cam)
	farmPagebutton.home_pressed.connect(switch_Cam)
	win.back_to_main_pressed.connect(switch_Cam)
	print("連接 win signal 中...")
	print("✅ win signal 已連接")

func switch_Cam(button_name):
	
	farmCam.enabled = false
	mainCam.enabled = false
	fightCam.enabled = false
	match button_name: 
		"farm":
			farmCam.enabled = true
		"home":
			print("切換到 home")
			mainCam.enabled=true
		"fight":
			fightCam.enabled=true
