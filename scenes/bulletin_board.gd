extends Control
#@onready var bgm_player = $BGMPlayer



# 市場狀態：0 = 跌勢，1 = 漲勢
var market_state: int = 0

# Timer 節點名稱
@onready var market_timer: Timer = $MarketTimer

func _ready():
	if not GlobalBGM.bgm_player.is_playing():
		GlobalBGM.bgm_player.play()
	#bgm_player.play()
	randomize()  # 初始化亂數種子
	market_timer.wait_time = 60.0  # 每 60 秒觸發一次
	market_timer.start()
	_update_market()  # 初始化一次市場狀態

func _on_MarketTimer_timeout():
	_update_market()

func _update_market():
	market_state = randi_range(0, 1)
	if market_state == 0:
		print("📉 市場呈現跌勢")
		# 這裡可以加上 UI 顯示邏輯，例如變紅色箭頭
	else:
		print("📈 市場呈現漲勢")
		# 這裡可以加上 UI 顯示邏輯，例如變綠色箭頭
