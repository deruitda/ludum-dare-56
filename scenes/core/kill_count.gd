extends Label

var enemy_kill_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(enemy_kill_count)

func set_enemy_kill_count(enemy_kill_count: int) -> void:
	text = "Kill Count: " + str(enemy_kill_count)
	
