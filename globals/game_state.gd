extends Node

@onready var game_is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.set_game_is_paused_state.connect(_on_set_game_is_paused_state)
	pass # Replace with function body.

func _on_set_game_is_paused_state(new_game_is_paused_value: bool):
	game_is_paused = new_game_is_paused_value
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
