extends Node2D

var is_spawning : bool = false

func _ready() -> void:
	$SpawnTimer.timeout.connect(_on_larvae_timer_timeout)

func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation == "spawn" && $AnimatedSprite2D.is_playing() == false:
		$AnimatedSprite2D.play("idle")

func _on_larvae_timer_timeout() -> void:
	is_spawning = true
	$AnimatedSprite2D.play("spawn")
