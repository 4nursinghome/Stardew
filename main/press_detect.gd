extends Control

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		GlobalSfx.play_click()
		mouse_filter = Control.MOUSE_FILTER_PASS
		
