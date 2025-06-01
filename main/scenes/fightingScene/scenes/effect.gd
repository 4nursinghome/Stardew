extends Node2D

@onready var skill1=$skill/skill1
@onready var ULT=$Ultimate/ULT
@onready var special=$special
@onready var enemy_skill1=$enemy_skill/enemy_skill1
func _ready():
	skill1.hide()
	ULT.hide()
	enemy_skill1.hide()
	special.hide()
func play_skill(skill_name:String):
	match skill_name:
		"skill1":
			skill1.show()
			match skillStats.get_skill_level(skill_name):
				0:
					skill1.play("humiliation")
				1:
					skill1.play("air_gun")
				2: 
					skill1.play("spark2")
			print (skillStats.get_skill_level(skill_name))
			await skill1.animation_finished
			skill1.visible=false
		"special":
			special.show()
			var rand = randi_range(1,10)
			if rand==1:
				special.play("rainbow")
			else :
				match skillStats.get_skill_level(skill_name):
					0:
						special.play("green")
					1:
						special.play("blue")
					2: 
						special.play("purple")
			await special.animation_finished
			special.hide()
		"ULT":
			ULT.show()
			match skillStats.get_skill_level(skill_name):
				0:
					ULT.play("shot")
				1:
					ULT.play("nuclear")
				2: 
					ULT.play("blackhole")
			await ULT.animation_finished
			print (skillStats.get_skill_level(skill_name))
			ULT.hide()
		
func play_enemy_skill1():
	enemy_skill1.show()
	enemy_skill1.play("spark")
	await enemy_skill1.animation_finished
	enemy_skill1.hide()
