extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.spawn_enemy.connect(spawn_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_enemy(scene: PackedScene, pos: Vector2) -> void:
	var enemy = scene.instantiate()
	enemy.set_global_position(pos)
	get_parent().add_child(enemy)
