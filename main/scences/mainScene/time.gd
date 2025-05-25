extends Label

func _ready():
	# 顯示一次（也可以放到 _process 裡每幀更新）
	update_time()

func _process(delta):
	update_time()

func update_time():
	var dict = Time.get_datetime_dict_from_system()

	var time_text = str(dict["year"]) + "-" + \
					str(dict["month"]).pad_zeros(2) + "-" + \
					str(dict["day"]).pad_zeros(2) + " " + \
					str(dict["hour"]).pad_zeros(2) + ":" + \
					str(dict["minute"]).pad_zeros(2) + ":" + \
					str(dict["second"]).pad_zeros(2)

	text = time_text
