extends Node2D
class_name CutSceneRex
@onready var walk_speed: float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_walk(direction: Vector2, delta: float):
	position += Vector2.RIGHT * walk_speed * delta
