extends Control

const SHOW_DURATION := 1.0
const MAX_STACK := 4

@onready var icon = $TextureRect/HBoxContainer/Icon
@onready var label = $TextureRect/HBoxContainer/RichTextLabel

var count := 1
var tween: Tween
var timer: Timer

func setup(_icon_tex: Texture2D):
	count = 1
	icon.texture = _icon_tex
	label.text = "x1"
	self.modulate.a = 1.0

	# 放右上角
	var screen_size = get_viewport_rect().size
	self.global_position = Vector2(screen_size.x - self.size.x + 450, 100)  # 右上角

	# 啟動計時器
	timer = Timer.new()
	timer.wait_time = SHOW_DURATION
	timer.one_shot = true
	timer.timeout.connect(_start_fade_out)
	add_child(timer)
	timer.start()

func add_stack():
	if count < MAX_STACK:
		count += 1
	label.text = "x%d" % count
	self.modulate.a = 1.0
	timer.start()  # 重置消失時間

	if tween:
		tween.kill()  # 取消淡出動畫，避免中途 queue_free

func _start_fade_out():
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.3)
	tween.tween_callback(Callable(self, "queue_free"))
