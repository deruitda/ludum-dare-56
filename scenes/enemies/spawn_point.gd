extends Node2D

@export var scene : PackedScene
@export var timer : Timer
@export var animSprite : AnimatedSprite2D
@export var spawn_range : int = 1000

func _ready() -> void:
	timer.timeout.connect(_on_spawn_timer_timeout)
	animSprite.animation_finished.connect(_on_anim_finished)

func _on_spawn_timer_timeout() -> void:
	# play the 'spawn' animation, when that animation is complete it will trigger 
	# the _on_anim_finished callback to spawn the enemy scene
	if is_player_in_range():
		animSprite.play("spawn")

func _on_anim_finished() -> void:
	if animSprite.animation == "spawn":
		SignalBus.spawn_enemy.emit(scene, global_position, global_rotation)
		animSprite.play("idle")

func is_player_in_range() -> bool:
	var player = PlayerManager.current_player
	
	if !player:
		return false
		
	var distance = player.global_position.distance_to(self.global_position)
	
	if distance < spawn_range:
		return true
		
	return false
	
