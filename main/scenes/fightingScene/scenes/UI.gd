extends Control

@onready var player_healthBar = $player_healthBar
@onready var enemy_healthBar=$enemy_healthBar
func player_update_hp(new_hp: int, max_hp: int):
	player_healthBar.max_value = max_hp
	player_healthBar.value = min(new_hp,max_hp)
func enemy_update_hp(new_hp: int,max_hp: int):
	enemy_healthBar.max_value = max_hp
	enemy_healthBar.value = min(new_hp,max_hp)
