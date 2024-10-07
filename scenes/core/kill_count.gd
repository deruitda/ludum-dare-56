extends Label

var enemy_kill_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.enemy_died.connect(_on_enemy_died)
	text = str(enemy_kill_count)

func _on_enemy_died() -> void:
	enemy_kill_count += 1
	text = str(enemy_kill_count)
	
