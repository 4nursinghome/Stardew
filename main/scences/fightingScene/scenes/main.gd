extends Node2D
signal button_W_L_pressed(button_name: String)
@onready var camera = $Camera2D
@onready var UI = $UI
@onready var player = $player
@onready var enemy = $enemy
@onready var effect = $effect
@onready var buttons=$buttons
@onready var win=$win
@onready var game_over=$GameOver
var player_stats:SkillStats=SkillStats.new()
var enemy_stats:enemyStats=enemyStats.new()
var shake_amount = 0.0
var player_damage_taken = 0
var enemy_damage_taken=0
var active := false 
func _ready():
	var main = get_tree().current_scene
	if main.has_signal("change_enemy"):
		print("change_enemy")
		main.change_scene.connect(enemy_autoAttack)
	#win.hide()
	#game_over.hide()
	win.restart.connect(button)
	win.back_to_main_pressed.connect(button)
	game_over.back_to_main_pressed.connect(button)
	game_over.restart.connect(button)
	buttons.skill_pressed.connect(on_skill_triggered)
	player.play_idle()
	enemy.enemy_attack.connect(player_hp_changed)
	player.player_die.connect(player_die)
	enemy.enemy_die.connect(enemy_die)
func start():
	if active:
		return
	active = true
	print("fight 正式啟動！")
	print("🔥 start called, active =", active)
	
func pause():
	active = false
	print("⏸️ fight 暫停中")

func resume():
	if not active:
		active = true
		print("▶️ fight 恢復進行")
func enemy_autoAttack(enemy_number):
	enemy.diffEnemy(enemy_number)
	await get_tree().create_timer(3.0).timeout
	while is_inside_tree() and player.player_current_hp>0 and enemy.enemy_current_hp>0 :
		await enemy.throw()
		print(enemy_number)
		effect.play_enemy_skill1()
func button(button_name):
	print(button_name)
	emit_signal("button_W_L_pressed",button_name)
func player_die():
	game_over.show()
func player_hp_changed(damage):
	player_damage_taken+=damage
	UI.player_update_hp(player_damage_taken,player_stats.healthGetter())
	player.take_damage(damage)
func enemy_die():
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
	

func on_skill_triggered(skill_name):
	var skill1_damage=player_stats.Skill1DamageGetter()
	var ULT_damage =player_stats.ULTDamageGetter()
	match skill_name:
		"skill1":
			effect.play_skill1()
			player.throw()
			enemy_damage_taken+=skill1_damage
			trigger_camera_shake(skill1_damage)
			enemy.take_damage(skill1_damage)
			UI.enemy_update_hp(enemy_damage_taken,100)
		"ULT":
			effect.play_ULT()
			player.throw()
			
			enemy_damage_taken+=ULT_damage
			trigger_camera_shake(ULT_damage)
			enemy.take_damage(ULT_damage)
			UI.enemy_update_hp(enemy_damage_taken,100)
		"escape":
			player.die()
