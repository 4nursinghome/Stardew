extends Label

func _process(_delta):
	text = str(GlobalProperty.Property["Coin"])
	
