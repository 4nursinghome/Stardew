extends Node2D
signal dialog_end
signal end_game
signal button_W_L_pressed(button_name: String)
@onready var camera = $Camera2D
@onready var UI = $UI
@onready var player = $player
@onready var enemy = $enemy
@onready var effect = $effect
@onready var buttons=$buttons
@onready var win=$win
@onready var game_over=$GameOver
@onready var dialog=$dialogue
var shake_amount = 0.0
var player_damage_taken = 0
var enemy_damage_taken=0
var active := false 
var enemy_attacking=false
var dialog_ended := false
func _ready():
	
	
	#win.hide()
	#game_over.hide()
	dialog.visible = false
	dialog.set_process_input(false)
	dialog.hide()
	dialog.mouse_filter=dialog.MOUSE_FILTER_IGNORE
	UI.hide()
	buttons.hide()
	win.restart.connect(button)
	win.back_to_main_pressed.connect(button)
	game_over.back_to_main_pressed.connect(button)
	game_over.restart.connect(button)
	buttons.skill_pressed.connect(on_skill_triggered)
	player.play_idle()
	enemy.enemy_attack.connect(player_hp_changed)
	player.player_die.connect(player_die)
	enemy.enemy_die.connect(enemy_die)
	print("fight init")
	var main = get_tree().current_scene
	if main.has_signal("change_enemy"):
		dialog.end_dialog.connect(end_dialog)
		main.change_scene.connect(diffenemy)
		print("change_enemy")
		main.openDialogue.connect(start)
	
		
func start():
	if active:
		return
	active = true
	dialog.show()
	dialog.visible = true
	dialog.set_process_input(true)
	dialog.mouse_filter=dialog.MOUSE_FILTER_STOP
	
	print("fight 正式啟動！")
	print("🔥 start called, active =", active)
func last_dialogue():
	active = false
	if skillStats.levelGetter() == 9:
		skillStats.next_level(10)
		print("last dialogue start")
		UI.hide()
		enemy.hide()
		buttons.hide()

		# 🔁 補上重新載入對話內容的邏輯
		dialog.dialog_ended = false
		dialog.load_dialogue_for_level(10)
		dialog.current_index = 0
		dialog.show_line(0)
		start()
		dialog_ended = false
		
		dialog.last_dialog.connect(end_dialog)
func pause():
	active = false
	print("⏸️ fight 暫停中")
func end_dialog():
	if dialog_ended:
		return
	dialog_ended = true
	if skillStats.levelGetter()==10:
		await get_tree().process_frame
		print("game restarting")
		skillStats.reset()
		EnemyStats.reset()
		GlobalProperty.reset()
		StoreStage.reset()
		get_tree().change_scene_to_file("res://scenes/combined_main.tscn")
	else :
		dialog.hide()
		UI.show()
		buttons.show()
		enemy_autoAttack()
func resume():
	if not active:
		active = true
		print("▶️ fight 恢復進行")

func diffenemy(enemy_number):
	enemy.diffEnemy(enemy_number)
	print(enemy_number)
	if skillStats.WinorLose==true:
		EnemyStats.Upgrade()
	

func enemy_autoAttack():
	if enemy_attacking==true:
		return
	else:
		enemy_attacking=true
		await get_tree().create_timer(1.0).timeout
		while is_inside_tree() and player.player_current_hp>0 and enemy.enemy_current_hp>0 :
			await enemy.throw()
			effect.play_enemy_skill1()
func button(button_name):
	print(button_name)
	emit_signal("button_W_L_pressed",button_name)
func player_die():
	game_over.show()
func player_hp_changed(damage):
	player_damage_taken += damage
	player.take_damage(damage)
	UI.player_update_hp(player_damage_taken, skillStats.healthGetter())

func enemy_die():
	if skillStats.levelGetter()==9:
		await get_tree().create_timer(1.0).timeout
		print("endddddddd")
		last_dialogue()
	else :
		await get_tree().create_timer(1.0).timeout
		win.show()
func _process(delta):
	if not active:
		return  # 停止處理
	# 放入你要進行的行為，例如：
	if shake_amount > 0:
		camera.offset = Vector2(
		randf_range(-shake_amount, shake_amount),
		randf_range(-shake_amount, shake_amount)
		)
		shake_amount = lerp(shake_amount, 0.0, delta * 5)
	else:
		camera.offset = Vector2.ZERO

func trigger_camera_shake(amount: float):
	shake_amount = amount
	
func player_hp_add(heal_amount):
	player_damage_taken -= heal_amount
	player.take_damage(-heal_amount)
	UI.player_update_hp(player_damage_taken, skillStats.healthGetter())

func on_skill_triggered(skill_name):
	var skill1_damage=skillStats.Skill1DamageGetter()
	var ULT_damage =skillStats.ULTDamageGetter()
	match skill_name:
		"skill1":
			effect.play_skill(skill_name)
			player.skill()
			print("skill name in main",skill_name)
			enemy_damage_taken+=skill1_damage
			trigger_camera_shake(skill1_damage)
			enemy.take_damage(skill1_damage)
			UI.enemy_update_hp(enemy_damage_taken,EnemyStats.healthGetter())
		"special":
			player.special(skillStats.specialDamageGetter())
			effect.play_skill(skill_name)
			trigger_camera_shake(skillStats.specialDamageGetter())
			player_hp_add(skillStats.specialDamageGetter())
			print("skill special")
		"ULT":
			
			effect.play_skill(skill_name)
			enemy_damage_taken+=ULT_damage
			trigger_camera_shake(ULT_damage)
			enemy.take_damage(ULT_damage)
			UI.enemy_update_hp(enemy_damage_taken,EnemyStats.healthGetter())
		"escape":
			player.die()
