extends Sprite2D

@export var total_frames := 3
@export var grow_times := 5.0
@export var auto_grow := true  # ✨ 新增：是否一進場就自動生長

var current_frame := 0
var is_ready := false
var timer: Timer

func _ready():
	frame = 0
	current_frame = 0
	is_ready = false

	timer = Timer.new()
	timer.wait_time = grow_times
	timer.one_shot = false
	timer.autostart = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

	# 初始化粒子關閉
	var particles = get_parent().get_node("HarvestParticles")
	if is_instance_valid(particles):
		particles.visible = false
		particles.emitting = false

	if auto_grow:
		_start_growth()  # ✨ 如果是直接開放的農田，馬上開始生長

func _start_growth():
	if is_instance_valid(timer):
		timer.start()

func _on_timer_timeout():
	if current_frame < total_frames - 1:
		current_frame += 1
		frame = current_frame

		if current_frame == total_frames - 1:
			is_ready = true
			_play_looping_harvest_effect()

func _play_looping_harvest_effect():
	var particles = get_parent().get_node("HarvestParticles")
	if is_instance_valid(particles):
		particles.visible = true
		particles.emitting = true

func reset_crop():
	current_frame = 0
	frame = current_frame
	is_ready = false
	var particles = get_parent().get_node("HarvestParticles")
	if is_instance_valid(particles):
		particles.visible = false
		particles.emitting = false
	if is_instance_valid(timer):
		timer.start()
