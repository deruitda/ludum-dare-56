extends Label

var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_health_changed.connect(_set_current_health)
	self.text = str(health)

func _set_current_health(new_health: int) -> void:
	health = new_health
	self.text = str(health)
