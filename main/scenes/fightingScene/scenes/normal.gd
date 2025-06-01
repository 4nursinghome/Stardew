extends Area2D

@export var skilltext: Label              # 拖入顯示等級的 Label
@export var costtext: Label               # 拖入顯示金額的 Label
@export var skill_index: int = 1          # 這個技能是第幾個（1～4）
@export var totalframes: int = 2          # 升級次數（2 有 3 個階段）
@export var skill_sprite: Sprite2D 

var current_frame := 0

var upgrade_costs = {
	1: [25, 75],
	2: [50, 150],
	3: [100, 300],
	4: [50, 150]
}

func _ready():
	update_texts()

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if current_frame < totalframes:
			var cost = upgrade_costs[skill_index][current_frame]
			if GlobalProperty.Property["Coin"] >= cost:
				GlobalProperty.Property["Coin"] -= cost

				match skill_index:
					1:
						skillStats.skill1Upgrade()
						print("🔺 Skill1 升級：Damage = ", skillStats.Skill1DamageGetter(), ", CD = ", skillStats.skill1CDGetter())
					2:
						skillStats.specialUpgrade() ## remember change
					3:
						skillStats.ULTUpgrade()
					4:
						skillStats.healthUpgrade()
				current_frame += 1
				skill_sprite.frame = current_frame
				skillStats.set_skill_level(skill_index)
				update_texts()
			else:
				print("❌ 金幣不足，需：", cost)
		else:
			print("✅ 已達最高等級")

func update_texts():
	skilltext.text = "Lv " + str(current_frame+1)
	if current_frame < totalframes:
		var next_cost = upgrade_costs[skill_index][current_frame]
		costtext.text = str(next_cost)
	else:
		costtext.text = "MAX"
