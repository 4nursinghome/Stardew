extends Area2D
@onready var ULTtext=$ULTtext
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		skillStats.ULTUpgrade()
		print("🔺 ULT 升級：Damage = ", skillStats.ULTDamageGetter(), ", CD = ", skillStats.ULTCDGetter())
		ULTtext.text="00002222"
