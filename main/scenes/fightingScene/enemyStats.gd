extends Node
class_name enemyStats  # 可以讓其他腳本直接引用
var _health:=100
var _Damage := 5
var _CD:=1
# Getter / Setter
func Upgrade()->void:
	_Damage=int(_Damage**1.05)
	_CD-=int(_CD**0.95)
	_health+=25
func reset():
	_health=100
	_Damage=5
	_CD=1
func healthUpgrade()->void:
	_health=int(_health**1.05)
func healthGetter()->float:
	return _health
func CDGetter()->float:
	return _CD
func damage()->int:
	return _Damage
