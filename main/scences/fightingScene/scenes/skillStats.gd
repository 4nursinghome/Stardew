extends Node
class_name SkillStats  # 可以讓其他腳本直接引用

var _health := 100
var _skill1Damage :float = 10
var _skill1CD :float = 0.5
var _specialDamage := 20
var _specialCD :float = 2
var _ULTDamage :float= 50
var _ULTCD :float = 10
#
var WinorLose:bool=true
# 技能等級
var _skill1Level := 0
var _specialLevel := 0
var _ULTLevel := 0
var _healthLevel := 0
var _level=1
func next_level(levels:int):
	_level=levels
	print("level : ", _level)
	
func reset():
	_health = 100
	_skill1Damage = 10
	_skill1CD =0.5
	_specialDamage = 20
	_specialCD =  2
	_ULTDamage = 100
	_ULTCD = 10
	_skill1Level=0
	_specialLevel=0
	_ULTLevel=0
	_healthLevel=0
	_level=1
func levelGetter()->int:
	return _level
# 升級方法
func skill1Upgrade() -> void:
	_skill1Damage *= 1.15
	_skill1CD -= 0.1

func healthUpgrade() -> void:
	_health = int(_health * 1.05)

func specialUpgrade() -> void:
	_specialDamage += 20
	_specialCD -= 0.3

func ULTUpgrade() -> void:
	_ULTDamage *=3
	_ULTCD -= 1

# 等級同步
func set_skill_level(index: int) -> void:
	match index:
		1:
			_skill1Level+=1
		2:
			_specialLevel +=1
		3:
			_ULTLevel +=1
		4:
			_healthLevel +=1
# 等級同步
func Win()->bool:
	WinorLose=true
	print("winfcvfcygvvyu  ",WinorLose)
	return WinorLose
func Lose()->bool:
	WinorLose=false
	return WinorLose
func get_skill_level(skill_name: String)->int:
	match skill_name:
		"skill1":
			return _skill1Level
		"special":
			return _specialLevel
		"ULT":
			return _ULTLevel
		_:
			return 0
	
func skill_levelUp(skill_name):
	match skill_name:
		"skill":
			_skill1Level+=1
		"special":
			_specialLevel+=1
		"ULT":
			_ULTLevel+=1
# Getter
func healthGetter() -> float:
	return _health

func Skill1DamageGetter() -> float:
	return _skill1Damage

func skill1CDGetter() -> float:
	return _skill1CD

func specialDamageGetter() -> float:
	return _specialDamage

func specialCDGetter() -> float:
	return _specialCD

func ULTDamageGetter() -> int:
	return _ULTDamage

func ULTCDGetter() -> float:
	return _ULTCD
