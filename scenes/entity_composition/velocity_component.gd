extends Node
class_name VelocityComponent

@export var gravity: float = 2000.0 
@export var max_speed: float = 1000.0
@export var acceleration = 3000.0
@export var in_air_acceleration: float = 3000.0
@export var in_air_deceleration: float = 30000.0
@export var in_air_resistance: float = 300.0
@export var jump_velocity: float = 1200.0
@export var wall_jump_velocity: float = 1500.0
@export var wall_slide_speed: float = 50.0
@export var floor_resistance: float = 8000.0

@export var wall_jump_time: float = 0.5
@onready var time_after_wall_jump: float = 0.0
@onready var is_wall_jumping: bool = false

@export var deceleration: float = 30000.0


@onready var velocity: Vector2
@onready var current_rotation: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	if is_wall_jumping:
		time_after_wall_jump += delta
		if time_after_wall_jump > wall_jump_time:
			is_wall_jumping = false
			time_after_wall_jump = 0.0
	pass

func apply_wall_jump(direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		velocity.x = wall_jump_velocity
	elif direction == Vector2.LEFT:
		velocity.x = -wall_jump_velocity
	else:
		assert("Direction should be either left or right when wall jumping")
	velocity.y = -jump_velocity
	is_wall_jumping = true
	
	
	# Determine wall side and apply horizontal force
func apply_floor_jump() -> void:
	velocity.y = -jump_velocity
func apply_launch(new_velocity: Vector2) -> void:
	velocity = new_velocity
func apply_wall_slide() -> void:
	velocity.y = min(velocity.y, wall_slide_speed)
	velocity.x = 0
func apply_move(direction: Vector2, delta: float) -> void:
	var acceleration_metric = acceleration
	var deceleration_metric = deceleration

	# Handle X-axis
	if sign(direction.x) != sign(velocity.x) and velocity.x != 0:
		# If the direction is opposite to the current velocity, apply deceleration
		velocity.x = clamp(velocity.x + (direction.x * deceleration_metric * delta), -max_speed, max_speed)
	else:
		# Otherwise, apply regular acceleration
		velocity.x = clamp(velocity.x + (direction.x * acceleration_metric * delta), -max_speed, max_speed)

	# Handle Y-axis
	if sign(direction.y) != sign(velocity.y) and velocity.y != 0:
		# Apply deceleration for opposite direction
		velocity.y = clamp(velocity.y + (direction.y * deceleration_metric * delta), -max_speed, max_speed)
	else:
		# Otherwise, apply regular acceleration
		velocity.y = clamp(velocity.y + (direction.y * acceleration_metric * delta), -max_speed, max_speed)
func apply_in_air_movement(direction: float, delta: float) -> void:
	var acceleration_metric = in_air_acceleration
	var deceleration_metric = in_air_deceleration # Add a separate deceleration for air if needed

	# Handle X-axis movement in air
	if not is_wall_jumping and sign(direction) != sign(velocity.x) and velocity.x != 0:
		# If the direction is opposite to the current velocity, apply deceleration
		velocity.x = clamp(velocity.x + (direction * deceleration_metric * delta), -max_speed, max_speed)
	else:
		# Otherwise, apply regular acceleration
		velocity.x = clamp(velocity.x + (direction * acceleration_metric * delta), -max_speed, max_speed)

func apply_in_air_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, in_air_resistance * delta)

func apply_hit_ground() -> void:
	velocity.y = 0

func apply_idle(delta: float):
	velocity.x = move_toward(velocity.x, 0, floor_resistance * delta)

func do_character_move(character_body: CharacterBody2D):
	
	character_body.velocity = velocity.rotated(current_rotation)
	character_body.move_and_slide()

func do_rigid_body_move(rigid_body: RigidBody2D):
	rigid_body.apply_central_impulse(velocity * rigid_body.mass)	
func set_rotation(rotation: float) -> void:
	current_rotation = rotation

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	
func apply_hit_cieling() -> void:
	velocity.y = 0
