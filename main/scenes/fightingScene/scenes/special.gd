extends Area2D
@onready var specialtext=$specialtext
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		skillStats.specialUpgrade()
		print("🔺 special 升級：Damage = ", skillStats.specialDamageGetter(), ", CD = ", skillStats.specialCDGetter())
		specialtext.text="2222"
