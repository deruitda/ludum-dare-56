extends Node2D
class_name LevelEntrance

@onready var rex: CutSceneRex = $Rex
@onready var walkout_timer: Timer = $Timer
@onready var checkpoint: Checkpoint = $Checkpoint

signal create_player(new_global_position: Vector2, starting_checkpoing: Checkpoint)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rex.walk_speed = 50.0
	SignalBus.set_game_is_paused_state.emit(true)
	rex.start_walk(Vector2.RIGHT)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_walkout_timer_timeout() -> void:
	rex.stop_walk()
	create_player.emit(rex.global_position, checkpoint)
	rex.queue_free()
	
