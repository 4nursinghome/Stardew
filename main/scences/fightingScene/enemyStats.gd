
class_name enemyStats  # 可以讓其他腳本直接引用
var _health:=100
var _Damage := 50
var _CD:=4
# Getter / Setter
func Upgrade()->void:
	_Damage=int(_Damage**1.15)
	_CD-=int(_CD**0.95)
func healthUpgrade()->void:
	_health=int(_health**1.05)
func healthGetter()->float:
	return _health
func CDGetter()->float:
	return _CD
func damage()->int:
	return _Damage
