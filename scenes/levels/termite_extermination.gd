extends Node2D

@onready var player_packed_scene = preload("res://scenes/player/player.tscn")
@onready var follow_cam: FollowCam = $FollowCam
@onready var level_entrance: LevelEntrance = $LevelEntrance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_entrance.create_player.connect(_on_level_entrance_create_player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_entrance_create_player(new_global_position: Vector2, starting_checkpoint: Checkpoint) -> void:
	var player = player_packed_scene.instantiate()
	player.global_position = new_global_position
	add_child(player)
	follow_cam.follow_target = player
	SignalBus.set_new_checkpoint.emit(starting_checkpoint)
	SignalBus.set_game_is_paused_state.emit(false)
	pass # Replace with function body.
