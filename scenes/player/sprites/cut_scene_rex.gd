extends Node2D
class_name CutSceneRex
@onready var walk_speed: float = 400.0
@onready var is_walking: bool = false
@onready var walking_direction: Vector2

@onready var lower_body: AnimatedSprite2D = $LowerBody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_walking:
		position += Vector2.RIGHT * walk_speed * delta
	
	pass

func start_walk(new_direction: Vector2):
	is_walking = true
	walking_direction = new_direction
	lower_body.play("walking")
	
	
func stop_walk() -> void:
	is_walking = false
	lower_body.play("idle")
