extends Area2D
signal hp_changed(new_hp)
signal player_die
var playerStats:SkillStats=SkillStats.new()
@onready var playerAnimate= $playerAnimation
var player_max_hp = playerStats.healthGetter()
var player_current_hp = player_max_hp

func play_idle():
	playerAnimate.play("idle")
	#print("play idle")
func throw():
	playerAnimate.play("throw")
	await playerAnimate.animation_finished
	playerAnimate.play("idle")
	#print("throw")
func take_damage(amount):
	
	player_current_hp -= amount
	player_current_hp = max(player_current_hp, 0)
	#emit_signal("hp_changed", player_current_hp)
	#print(player_current_hp)
	if player_current_hp == 0:
		die()
func heal(amount):
	player_current_hp += amount
	player_current_hp = min(player_current_hp, player_max_hp)
	emit_signal("hp_changed", player_current_hp)

func die():
	playerAnimate.play("die")
	await playerAnimate.animation_finished
	emit_signal("player_die")
