extends Area2D
signal building_pressed(button_name: String)
signal nextShow(show:int)
var add:int
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("building_pressed", name.substr(name.length() - 1, 1)) 
		print(name)
		
		var main = get_tree().current_scene
		main.fightEnd.connect(bun)
func bun():
	add=int(name.substr(name.length() - 1, 1))
	emit_signal("nextShow",add+1)
