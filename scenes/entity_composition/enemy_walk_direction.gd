extends Node
class_name EnemyWalkDirection
@onready var current_direction: Vector2 = Vector2.ZERO
@export var toggle_current_direction_timer = Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_current_direction() -> void:
	if current_direction == Vector2.RIGHT:
		current_direction = Vector2.LEFT 
	elif current_direction == Vector2.LEFT: 
		current_direction = Vector2.RIGHT
	elif current_direction == Vector2.UP:
		current_direction == Vector2.DOWN
	elif current_direction == Vector2.DOWN:
		current_direction == Vector2.UP

func set_current_direction(new_current_direction: Vector2) -> void:
	current_direction = new_current_direction 

func is_running() -> bool:
	return current_direction == Vector2.LEFT or current_direction == Vector2.RIGHT
	
