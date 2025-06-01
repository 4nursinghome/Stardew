extends Area2D
signal enemy_attack
signal enemy_die
var died=false
@onready var enemyAnimate= $enemyAnimation
var enemy_max_hp = EnemyStats.healthGetter()
var enemy_current_hp=enemy_max_hp
var enemyCD=EnemyStats.CDGetter()
var enemy_name:String
func play_idle():
	enemyAnimate.play("idle")

func diffEnemy(enemy_number):
	enemy_name="enemy"+str(enemy_number)
	print(enemy_name)
	enemyAnimate.animation=enemy_name
func throw():
	emit_signal("enemy_attack",EnemyStats.damage())
	print("the fuck is crow doing: ",EnemyStats.damage())
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
	if died == true:
		return
	died=true
	#enemyAnimate.play("die")
	#await enemyAnimate.animation_finished
	emit_signal("enemy_die")
