extends CanvasLayer
class_name UI
@onready var kill_count: Label = $KillCountBackground/KillCount
@onready var death_count: Label = $DeathCountBackground/DeathCount
@onready var hp_background: Panel = $HPBackground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_state_changed.connect(_on_game_state_changed)
	_on_game_state_changed()
	pass # Replace with function body.

func _on_game_state_changed():
	hp_background.set_current_health(GameState.current_player_health)
	kill_count.set_enemy_kill_count(GameState.enemies_killed)
	death_count.set_player_death(GameState.player_deaths)
	pass
