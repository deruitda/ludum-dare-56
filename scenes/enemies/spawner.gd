extends Node2D

@export var scene : PackedScene
@export var timer : Timer

func _ready() -> void:
	timer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout() -> void:
	print("times up")
	SignalBus.spawn_enemy.emit(scene, global_position)
