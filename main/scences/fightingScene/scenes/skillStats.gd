
class_name SkillStats  # 可以讓其他腳本直接引用
var _health:=100
var _skill1Damage := 10
var _skill1CD :float= 2
var _skill2Damage := 10
var _skill2CD :float= 2
var _ULTDamage:=100
var _ULTCD:float=4
# Getter / Setter
func skill1Upgrade()->void:
	_skill1Damage=int(_skill1Damage**1.15)
	_skill1CD-=int(_skill1CD**0.95)
func healthUpgrade()->void:
	_health=int(_health**1.05)
func healthGetter()->float:
	return _health
func Skill1DamageGetter()->float:
	return _skill1Damage
func skill1CDGetter()->float:
	return _skill1CD

func skill2Upgrade() -> void:
	_skill2Damage+=5
	_skill2CD-=0.3

func ULTUpgrade() -> void:
	_ULTDamage+=30
	_ULTCD-=1
func ULTDamageGetter()->int:
	return _ULTDamage
