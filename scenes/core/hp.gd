extends Label

var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_hurt.connect(on_player_hurt)
	self.text = str(health)

func on_player_hurt() -> void:
	health -= 1
	self.text = str(health)
