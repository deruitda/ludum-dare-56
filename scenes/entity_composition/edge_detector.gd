extends Node2D
class_name EdgeDetector

@export var left_ray_cast: RayCast2D
@export var right_ray_cast: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_touching_ground() -> bool:
	return left_ray_cast.is_colliding() or right_ray_cast.is_colliding()

func get_hanging_direction() -> Vector2:
	if left_ray_cast.is_colliding() and not right_ray_cast.is_colliding():
		return Vector2.LEFT
	elif not left_ray_cast.is_colliding and right_ray_cast.is_colliding():
		return Vector2.RIGHT
	return Vector2.ZERO
