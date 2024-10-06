extends CharacterBody2D
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var toggle_direction_timer: Timer = $ToggleDirectionTimer
@onready var enemy_walk_direction: EnemyWalkDirection = $EnemyWalkDirection


@export var start_direction: Vector2 = Vector2.UP


@onready var current_direction: Vector2
func _ready() -> void:
	current_direction = start_direction

func _physics_process(delta: float) -> void:
	if is_on_wall():
		velocity_component.apply_climb(enemy_walk_direction.current_direction, delta)
	else:
		velocity_component.apply_run(enemy_walk_direction.current_direction, delta)


func toggle_current_direction() -> void:
	if current_direction == Vector2.RIGHT:
		current_direction = Vector2.LEFT 
	elif current_direction == Vector2.LEFT: 
		current_direction = Vector2.RIGHT
	elif current_direction == Vector2.UP:
		current_direction == Vector2.DOWN
	elif current_direction == Vector2.DOWN:
		current_direction == Vector2.UP
