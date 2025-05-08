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


我目前的進度是將遊戲主要架構設計好，所以未來技能和角色開發會比較方便。

技能的部分：
技能是由兩個控制系統控制，分別為特效與按鈕，後面會解釋這樣設計的原因和理由。
我目前有設計兩個技能，左邊的cd時間是2秒，傷害為10，右邊的是5秒，傷害為20，現在可以輕鬆的新增技能和冷卻時間了，前提是要畫得出技能圖片。

特效的部分：
我的特效是用一個node2d包裹area2d，類似於角色的collision與animation寫法，目前總共有3種特效，目前特效的新增很容易，跟技能一樣只要有動畫就能輕鬆新增

按鈕的部分：
按鈕是由control 控制，寫法與特效類似，都是用area 2d控制圖像與重疊，也就是判斷有沒有點擊。不過按鈕與特效不同的是，特效的effect.gd控制所有子節點（area 2d）的行為，而按鈕就像是中介層，負責接受較為統一的個別按鈕傳出的訊息，然後再傳給主場景（main.gd）

角色的部分：
未來新增角色的部分會有一點點複雜，因為角色需要控制的部分太多了，目前我的main.gd需要控制大部分的角色行為，所以未來新增角色的話main.gd程式撰寫會有點亂，未來我想要把角色放進個別的node2D或control 裡面去控制，不過那樣可能要將程式整個改寫，有點麻煩。

場景的控制：
目前遊戲結束、遊戲勝利與對話都是個別場景，目前順序是對話先觸發，對話結束後重設場景為主場景，接著再依main.gd（主場景）的控制結果判斷要切換哪個場景。
