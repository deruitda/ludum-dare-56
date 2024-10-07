extends Node2D

@onready var follow_cam: Camera2D = $FollowCam
@onready var termite_queen: ThermiteQueen = $TermiteQueen
@onready var player_packed_scene = preload("res://scenes/player/player.tscn")

@onready var time_before_explosion: Timer = $CutSceneTimers/TimeBeforeExplosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_termite_queen_queen_just_died() -> void:
	follow_cam.switch_target(termite_queen)
	time_before_explosion.start()
	time_before_explosion.timeout.connect(_on_time_before_explosion_timeout)
	pass # Replace with function body.

func _on_time_before_explosion_timeout() -> void:
	termite_queen.do_explode()
	pass


func _on_termite_queen_queen_explosion_finished() -> void:
	print("must emit now")
	SignalBus.termite_queen_is_dead.emit()
	pass # Replace with function body.


func _on_level_entrance_create_player(new_global_position: Vector2, starting_checkpoint: Checkpoint) -> void:
	var player = player_packed_scene.instantiate()
	player.global_position = new_global_position
	add_child(player)
	follow_cam.follow_target = player
	SignalBus.set_game_is_paused_state.emit(false)
	SignalBus.set_new_checkpoint.emit(starting_checkpoint)
	pass # Replace with function body.
