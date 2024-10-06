extends Node2D
class_name EdgeDetector

@export var left_ray_cast: RayCast2D
@export var right_ray_cast: RayCast2D

@onready var current_hanging_direction = Vector2.ZERO 

signal on_hanging_off_ground
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	set_hanging_direction()

func set_hanging_direction() -> void:
	var new_hanging_direction = get_hanging_direction()
	if current_hanging_direction != new_hanging_direction:
		current_hanging_direction = new_hanging_direction
		on_hanging_off_ground.emit()

func is_touching_ground() -> bool:
	return left_ray_cast.is_colliding() or right_ray_cast.is_colliding()

func get_hanging_direction() -> Vector2:
	if get_is_colliding(left_ray_cast) and not get_is_colliding(right_ray_cast):
		return Vector2.LEFT
	elif not  get_is_colliding(left_ray_cast) and get_is_colliding(right_ray_cast):
		return Vector2.RIGHT
	return Vector2.ZERO

func is_hanging_off_edge() -> bool:
	return get_hanging_direction() == Vector2.ZERO and is_touching_ground()

func get_is_colliding(raycast: RayCast2D):
	return raycast.is_colliding()
	
