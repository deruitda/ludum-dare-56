extends Area2D
class_name Bullet

@export var speed: float = 3000
@onready var direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _process(delta: float) -> void:
	position = position + (direction * speed * delta)
