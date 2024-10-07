extends Node
class_name RespawnComponent

@onready var current_checkpoint: Checkpoint

@export var respawn_idle_timer: Timer
@export var respawn_invulnerability_timer: Timer

@onready var is_respawn_idling: bool = false
@onready var is_invulnerable: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.set_new_checkpoint.connect(_set_new_checkpoint)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_new_checkpoint(new_checkpoint: Checkpoint) -> void:
	current_checkpoint = new_checkpoint

func do_respawn(character_body: CharacterBody2D):
	if current_checkpoint:
		character_body.global_position = current_checkpoint.get_spawn_position()
		is_respawn_idling = true
		respawn_idle_timer.start()
		respawn_idle_timer.timeout.connect(_on_respawn_idle_timer_timeout)
		
		is_invulnerable = true
		respawn_invulnerability_timer.start()
		respawn_invulnerability_timer.timeout.connect(_on_respawn_invulnerability_timer_timeout)

func _on_respawn_idle_timer_timeout() -> void:
	is_respawn_idling = false
	respawn_idle_timer.stop()
	respawn_idle_timer.timeout.disconnect(_on_respawn_idle_timer_timeout)
	pass

func _on_respawn_invulnerability_timer_timeout() -> void:
	
	is_invulnerable = false
	respawn_invulnerability_timer.stop()
	respawn_invulnerability_timer.timeout.disconnect(_on_respawn_invulnerability_timer_timeout)
