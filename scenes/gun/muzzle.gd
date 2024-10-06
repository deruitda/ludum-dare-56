extends Node2D
class_name Muzzle

@export var shooting_direction: Vector2 = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_bullet(bullet_packed_scene: PackedScene):
	var new_bullet_position = global_position
	var new_bullet = bullet_packed_scene.instantiate() as Bullet
	new_bullet.global_position = new_bullet_position
	var adjusted_direction = shooting_direction.rotated(global_rotation)
	new_bullet.set_direction(adjusted_direction)
	SignalBus.create_bullet.emit(new_bullet)
