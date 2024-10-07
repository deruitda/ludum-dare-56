extends Node
class_name EnemyWalkDirection
@onready var current_direction: Vector2 = Vector2.ZERO

@onready var is_on_floor: bool = false
@onready var is_on_ceiling: bool = false
@onready var is_on_wall: bool = false

@onready var toggle_cooldown_timer: Timer = $ToggleCooldownTimer

@export var set_random_start_direction: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if set_random_start_direction:
		var random_value = randi() % 2
		if random_value == 0:
			current_direction = Vector2.LEFT
		else:
			current_direction = Vector2.RIGHT
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_current_direction() -> void:
	if not toggle_cooldown_timer.is_stopped():
		return 
	if current_direction == Vector2.RIGHT:
		current_direction = Vector2.LEFT 
	elif current_direction == Vector2.LEFT: 
		current_direction = Vector2.RIGHT
	elif current_direction == Vector2.UP:
		current_direction = Vector2.DOWN
	elif current_direction == Vector2.DOWN:
		current_direction = Vector2.UP
	else:
		return
	
	toggle_cooldown_timer.start()
	
	

func set_current_direction(new_current_direction: Vector2) -> void:
	current_direction = new_current_direction 

func is_running() -> bool:
	return current_direction == Vector2.LEFT or current_direction == Vector2.RIGHT
	
func rotate_walk_direction() -> void:
	pass
