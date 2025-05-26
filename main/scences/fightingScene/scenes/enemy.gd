extends Area2D
signal enemy_attack
signal enemy_die
@onready var enemyAnimate= $enemyAnimation
var enemy_Stats:enemyStats=enemyStats.new()
var enemy_max_hp = enemy_Stats.healthGetter()
var enemy_current_hp=enemy_max_hp
var enemyCD=enemy_Stats.CDGetter()
var enemy_name:String
func play_idle():
	enemyAnimate.play("idle")

func diffEnemy(enemy_number):
	enemy_name="enemy"+str(enemy_number)
	print(enemy_name)
	enemyAnimate.animation=enemy_name
func throw():
	emit_signal("enemy_attack",enemy_Stats.damage())
	enemyAnimate.play(enemy_name)
	await enemyAnimate.animation_finished
	await get_tree().create_timer(enemyCD).timeout
func take_damage(amount):
	
	enemy_current_hp -= amount
	enemy_current_hp = max(enemy_current_hp, 0)
	#emit_signal("hp_changed", player_current_hp)
	print(enemy_current_hp)
	if enemy_current_hp == 0:
		die()
func die():
	#enemyAnimate.play("die")
	#await enemyAnimate.animation_finished
	emit_signal("enemy_die")
