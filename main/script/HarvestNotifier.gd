extends Control

const SHOW_DURATION := 1.0
const MAX_STACK := 4

@onready var icon = $TextureRect/HBoxContainer/Icon
@onready var label = $TextureRect/HBoxContainer/RichTextLabel

var count := 1
var tween: Tween = null

func setup(_crop: String, icon_tex: Texture2D):
	count = 1
	icon.texture = icon_tex
	label.text = "x1"
	self.modulate.a = 1.0
	var screen_size = get_viewport_rect().size
	self.global_position = Vector2(screen_size.x - self.size.x + 450, 100)  # 右上角


	  

func add_stack():
	if count < MAX_STACK:
		count += 1
	label.text = "x%d" % count
	self.modulate.a = 1.0

	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5).set_delay(SHOW_DURATION)
	tween.tween_callback(Callable(self, "queue_free"))
