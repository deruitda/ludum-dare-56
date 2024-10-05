extends Area2D
class_name Bullet

@export var speed: float = 3000
@export var damage_per_bullet = 1

@onready var direction: Vector2
@onready var has_hit_something = false
@onready var has_been_destroyed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _physics_process(delta: float) -> void:
	if has_hit_something and not has_been_destroyed:
		has_been_destroyed = true
		queue_free()
	elif not has_hit_something:
		position = position + (direction * speed * delta)

func _handle_hit_environment():
	has_hit_something = true
	
func _handle_hit_hurt_box():
	has_hit_something = true

func _on_area_entered(area: Area2D) -> void:
	_handle_hit_hurt_box()
	pass # Replace with function body.

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	_handle_hit_environment()
	pass # Replace with function body.
