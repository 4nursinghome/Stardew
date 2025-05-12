extends Area2D

@export var crop_nodes: Array[NodePath] = []

var unlocked := false

func _ready():
	for path in crop_nodes:
		if has_node(path):
			var crop_node = get_node(path)
			if crop_node:
				for child in crop_node.get_children():
					if child is Sprite2D or child is GPUParticles2D or child is CPUParticles2D:
						child.hide()
						if child is GPUParticles2D or child is CPUParticles2D:
							child.emitting = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not unlocked:
			unlocked = true
			for path in crop_nodes:
				if has_node(path):
					var crop_node = get_node(path)
					if crop_node:
						for child in crop_node.get_children():
							if child is Sprite2D or child is GPUParticles2D or child is CPUParticles2D:
								child.show()
								if child is Sprite2D:
									if child.has_method("set_frame"):
										child.set_frame(0)
									elif child.has_meta("frame"):
										child.frame = 0
								if child is GPUParticles2D or child is CPUParticles2D:
									child.emitting = false

						# ✨ 通用：找出 crop_node 裡所有 Sprite2D，讓有 _start_growth() 的開始生長
						for child in crop_node.get_children():
							if child is Sprite2D and child.has_method("_start_growth"):
								child._start_growth()

			$lock.queue_free()
			$coin2.queue_free()
			queue_free()
