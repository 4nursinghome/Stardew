<pre>
簡單的架構長這樣
[DialogueScene] →（change_scene_to_file）
    ↓
[Main] (Node2D)
├── Player (Area2D)
│   └── Signals: player_die, hp_changed
├── Enemy (Area2D)
│   └── Signals: enemy_attack
├── Buttons (Control)
│   ├── Skill1Button (Area2D)
│   └── Signals: skill1_pressed
├── UI (Control)
│   └── player HealthBar (TextureProgressBar)
｜   └── enemy HealthBar (TextureProgressBar)
｜   └── sprite 2D
├── Effect (Node2D)
│   ├── Skill1(Area2D)
│   └── Skill1body (collision)
├── Camera2D (Camera shake)
    ↓
[GameOverScene] / [VictoryScene]
</pre>
