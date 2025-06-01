extends Area2D
signal pressed(skill_name)
@onready var cooldown_timer = $special_cooldown
@onready var frame=$special
@export var skill_name: String = "special"
var can_cast := true
@onready var special=$special
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if can_cast:
			can_cast = false
			emit_signal("pressed",skill_name)
			start_cooldown(skillStats.specialCDGetter())
	

func _ready():
	cooldown_timer.timeout.connect(_on_cooldown_finished)
	special.frame=skillStats.get_skill_level(skill_name)
func start_cooldown(duration: float):
	cooldown_timer.wait_time = duration
	cooldown_timer.start()

func _on_cooldown_finished():
	can_cast = true
