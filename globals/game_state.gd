extends Node

@onready var game_is_paused: bool = false

@onready var enemies_killed: int
@onready var current_player_health: int
@onready var player_deaths: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_player_state()
	SignalBus.enemy_died.connect(_on_enemy_died)
	SignalBus.player_health_changed.connect(_set_current_health)
	SignalBus.player_died.connect(_on_player_death)
	SignalBus.set_game_is_paused_state.connect(_on_set_game_is_paused_state)

	pass # Replace with function body.

func reset_player_state():
	enemies_killed = 0
	current_player_health = 3
	player_deaths = 0
	
func _set_current_health(new_health: int) -> void:
	current_player_health = new_health
	SignalBus.game_state_changed.emit()

func _on_enemy_died(node: Node2D) -> void:
	enemies_killed += 1
	SignalBus.game_state_changed.emit()
	
func _on_player_death() -> void:
	player_deaths += 1
	SignalBus.game_state_changed.emit()

func _on_set_game_is_paused_state(new_game_is_paused_value: bool):
	game_is_paused = new_game_is_paused_value
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
