extends Label

var time_elapsed := 0.0
# You don't really need this
var is_started := false

func _ready() -> void:
	SignalBus.start_game.connect(on_start_game)
	SignalBus.termite_queen_is_dead.connect(on_game_over)

func on_start_game() -> void:
	is_started = true
	
func on_game_over() -> void:
	is_started = false

func _process(delta: float) -> void:
	if is_started:
		time_elapsed += delta
		self.text = str(time_elapsed).pad_decimals(2)
		SignalBus.game_time_change.emit(time_elapsed)

func reset() -> void:
	# possibly save time_elapsed somewhere else before overriding it
	time_elapsed = 0.0
	is_started = false

func stop() -> void:
	is_started = true
