extends Node
class_name VelocityComponent

@export var gravity: float = 2000.0 
@export var max_speed: float = 1000.0
@export var acceleration = 3000.0
@export var in_air_acceleration: float = 3000.0
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
func apply_move(direction: Vector2, delta: float) -> void:
		velocity.x = clamp(velocity.x + (direction.x * acceleration * delta), -max_speed, max_speed)
		velocity.y = clamp(velocity.y + (direction.y * acceleration * delta), -max_speed, max_speed)
	
func apply_in_air_movement(direction: float, delta: float) -> void:
	velocity.x = clamp(velocity.x + direction * in_air_acceleration * delta, -max_speed, max_speed)

func apply_in_air_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, in_air_resistance * delta)

func apply_hit_ground() -> void:
	velocity.y = 0

func apply_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, floor_resistance * delta)

func do_character_move(character_body: CharacterBody2D):
	print("current velocity", str(velocity))
	character_body.velocity = velocity
	character_body.move_and_slide()

func do_rigid_body_move(rigid_body: RigidBody2D):
	rigid_body.velocity = velocity
	rigid_body.move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	
func apply_hit_cieling() -> void:
	velocity.y = 0
