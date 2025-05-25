extends PathFollow2D  # 或 CharacterBody2D

@export var speed: float = 100.0

func _process(delta):
	# ——如果你是 PathFollow2D 自動跑的版本——
	offset += speed * delta

	# 取得當前路徑上“切線”角度（度數）
	var ang = rotation_degrees % 360

	# 切換面向：以 0° 為向右／側面，90°為向後，270°為向前
	if ang < 45 or ang > 315:
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = false    # 右邊
	elif ang >= 45 and ang < 135:
		$AnimatedSprite2D.play("back")      # 往後
	elif ang >= 135 and ang < 225:
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = true     # 左邊
	else:
		$AnimatedSprite2D.play("front")     # 往前
