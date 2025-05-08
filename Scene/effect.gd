extends Node2D

@onready var skill1=$skill/skill1
@onready var ULT=$Ultimate/ULT
@onready var enemy_skill1=$enemy_skill/enemy_skill1
func _ready():
	skill1.hide()
	ULT.hide()
	enemy_skill1.hide()
func play_skill1():
	skill1.show()
	skill1.play("spark")
	await skill1.animation_finished
	skill1.hide()
func play_ULT():
	ULT.show()
	ULT.play("kamehameha")
	await ULT.animation_finished
	ULT.hide()
func play_enemy_skill1():
	enemy_skill1.show()
	enemy_skill1.play("spark")
	await enemy_skill1.animation_finished
	enemy_skill1.hide()
