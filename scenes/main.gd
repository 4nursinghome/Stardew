extends Node2D
@onready var camera = $Camera2D
@onready var UI = $UI
@onready var player = $player
@onready var enemy = $enemy
@onready var effect = $effect
@onready var buttons=$buttons

var shake_amount = 0.0
var player_damage_taken = 0
var enemy_damage_taken=0

func _ready():
	buttons.skill_pressed.connect(on_skill_triggered)
	enemy_autoAttack()
	player.play_idle()
	enemy.play_idle()
	enemy.enemy_attack.connect(player_hp_changed)
	player.player_die.connect(player_die)
	enemy.enemy_die.connect(enemy_die)
func enemy_autoAttack():
	while is_inside_tree() and player.player_current_hp>0 :
		await get_tree().create_timer(3.0).timeout
		enemy.throw()
		effect.play_enemy_skill1()
func player_die():
	if is_inside_tree():
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
func player_hp_changed(damage):
	player_damage_taken+=damage
	UI.player_update_hp(player_damage_taken,100)
	player.take_damage(damage)
func enemy_die():
	if is_inside_tree():
		get_tree().change_scene_to_file("res://scenes/win.tscn")
func _process(delta):
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
	var skill1_damage=10
	var ULT_damage =20
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
