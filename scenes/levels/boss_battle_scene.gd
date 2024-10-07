extends Node2D

@onready var level_entrance: LevelEntrance = $LevelEntrance

@onready var follow_cam: FollowCam = $FollowCam
@onready var termite_queen: ThermiteQueen = $TermiteQueen
@onready var player_packed_scene = preload("res://scenes/player/player.tscn")

@onready var time_before_scream: Timer = $CutSceneTimers/TimeBeforeScream
@onready var time_after_scream_before_start: Timer = $CutSceneTimers/TimeAfterScreamBeforeStart
@onready var time_before_explosion: Timer = $CutSceneTimers/TimeBeforeExplosion
@onready var boss_health_bar: ProgressBar = $BossHealthBar

@onready var is_opening_cutscene: bool = true

@onready var background_music_audio = preload("res://assets/Audio/Music/BossEXT.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss_health_bar.value = termite_queen.health_component.current_health
	boss_health_bar.max_value = boss_health_bar.value
	termite_queen.pause_attack = true
	time_before_scream.start()
	time_before_scream.timeout.connect(_on_time_before_scream_timeout)
	
	SignalBus.pause_background_music.emit()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_opening_cutscene:
		termite_queen.rotate_to_direction(Vector2.DOWN, delta)
	pass

func _on_time_before_scream_timeout():
	termite_queen.do_initial_scream()
	time_before_scream.timeout.disconnect(_on_time_before_scream_timeout)

func _on_termite_queen_opening_scream_finished() -> void:
	time_after_scream_before_start.start()
	time_after_scream_before_start.timeout.connect(_on_time_after_scream_before_start_timeout)
	pass # Replace with function

func _on_time_after_scream_before_start_timeout() -> void:
	time_after_scream_before_start.timeout.disconnect(_on_time_after_scream_before_start_timeout)
	follow_cam.switch_target(level_entrance)
	level_entrance.start_walkout()
	pass # Replace with function

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
	
	termite_queen.pause_attack = false
	SignalBus.set_background_music.emit(background_music_audio)
	pass # Replace with function body.
