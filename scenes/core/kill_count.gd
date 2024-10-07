extends Label

var kill_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_kill.connect(on_player_kill)
	self.text = str(kill_count)

func on_player_kill() -> void:
	kill_count += 1
	text = str(kill_count)
	
