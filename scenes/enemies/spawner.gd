extends Node2D

@export var scene : PackedScene
@export var timer : Timer
@export var animSprite : AnimatedSprite2D

func _ready() -> void:
	timer.timeout.connect(_on_spawn_timer_timeout)
	animSprite.animation_finished.connect(_on_anim_finished)

func _on_spawn_timer_timeout() -> void:
	# play the 'spawn' animation, when that animation is complete it will trigger 
	# the _on_anim_finished callback to spawn the enemy scene
	animSprite.play("spawn")

func _on_anim_finished() -> void:
	print(animSprite.animation)
	if animSprite.animation == "spawn":
		SignalBus.spawn_enemy.emit(scene, global_position)
		animSprite.play("idle")
