extends Node
class_name VelocityComponent

@export var gravity: float = 2000.0 
@export var max_speed: float = 1000.0
@export var in_air_acceleration: float = 1800.0
@export var in_air_resistance: float = 300.0
@export var jump_velocity: float = 1200.0
@export var wall_jump_velocity: float = 1500.0
@export var wall_slide_speed: float = 50.0
@export var floor_resistance: float = 8000.0

@onready var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_wall_jump(direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		velocity.x = wall_jump_velocity
	elif direction == Vector2.LEFT:
		velocity.x = -wall_jump_velocity
	else:
		assert("Direction should be either left or right when wall jumping")
	velocity.y = -jump_velocity
	
	# Determine wall side and apply horizontal force
func apply_floor_jump() -> void:
	velocity.y = -jump_velocity

func apply_wall_slide() -> void:
	velocity.y = min(velocity.y, wall_slide_speed)
	velocity.x = 0

func apply_run(direction: Vector2) -> void:
	if direction == Vector2.RIGHT || direction == Vector2.LEFT:
		velocity.x = direction.x * max_speed
	else:
		assert("Direction should be either left or right when wall jumping")

func apply_in_air_movement(direction: float, delta: float) -> void:
	velocity.x = clamp(velocity.x + direction * in_air_acceleration * delta, -max_speed, max_speed)

func apply_in_air_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, in_air_resistance * delta)

func apply_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, floor_resistance * delta)

func do_character_move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	
func do_area_move(area: Area2D):
	area.position = area.position + velocity

func apply_fly(direction: Vector2, delta: float) -> void:
	velocity += direction * delta * max_speed

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
