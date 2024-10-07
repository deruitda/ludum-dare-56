extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.boss_hurt.connect(_on_boss_hurt)


func _on_boss_hurt():
	value -= 1
	
