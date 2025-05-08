extends Area2D
signal pressed(skill_name)
@onready var cooldown_timer = $skill1_cooldown
@export var skill_name: String = "skill1"
var can_cast := true
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if can_cast:
			can_cast = false
			emit_signal("pressed",skill_name)
			start_cooldown(1.0)

func _ready():
	cooldown_timer.timeout.connect(_on_cooldown_finished)

func start_cooldown(duration: float):
	cooldown_timer.wait_time = duration
	cooldown_timer.start()

func _on_cooldown_finished():
	can_cast = true
