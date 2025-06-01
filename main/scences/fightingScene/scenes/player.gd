extends Area2D
signal hp_changed(new_hp)
signal player_die
@onready var playerAnimate= $playerAnimation
var player_max_hp = skillStats.healthGetter()
var player_current_hp = player_max_hp

func play_idle():
	playerAnimate.play("idle")
	#print("play idle")
func skill():
	if skillStats.get_skill_level("skill1")==0:
		playerAnimate.play("skill")
	else:
		playerAnimate.play("special")
	await playerAnimate.animation_finished
	playerAnimate.play("idle")
	#print("throw")

func take_damage(amount):
	
	player_current_hp -= amount
	player_current_hp = max(player_current_hp, 0)
	#emit_signal("hp_changed", player_current_hp)
	print("player_hp : ",player_current_hp)
	if player_current_hp == 0:
		die()
func special(amount):
	playerAnimate.play("special")
	player_current_hp += amount
	player_current_hp = min(player_current_hp, player_max_hp)
	emit_signal("hp_changed", player_current_hp)
	await  playerAnimate.animation_finished
func ULT():
	if skillStats.get_skill_level("ULT")==0:
		playerAnimate.play("ULT")
	else:
		playerAnimate.play("special")
	await playerAnimate.animation_finished
	playerAnimate.play("idle")
func die():
	playerAnimate.play("die")
	await playerAnimate.animation_finished
	emit_signal("player_die")
