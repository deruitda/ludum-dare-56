extends Label

var death_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_died.connect(_on_player_death)
	self.text = str(death_count)

func _on_player_death() -> void:
	death_count += 1
	text = str(death_count)
	
