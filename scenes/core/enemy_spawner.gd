extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.spawn_enemy.connect(spawn_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_enemy(scene: PackedScene, pos: Vector2, rotation: float) -> void:
	var enemy = scene.instantiate() as Node2D
	enemy.set_global_position(pos)
	enemy.rotation = rotation
	get_parent().add_child(enemy)
