extends CharacterBody2D

@export var max_speed: float = 1000.0
@export var acceleration: float = 600.0
@export var jump_velocity: float = 1200.0
@export var gravity: float = 2000.0 
@export var wall_jump_velocity: float = 1500.0
@export var wall_slide_speed: float = 200.0
@export var air_resistance: float = 300.0

@onready var is_floor_jumping: bool = false
@onready var is_wall_jumping: bool = false
@onready var is_wall_sliding: bool = false



@onready var direction_input: float = 0.0


func _physics_process(delta: float) -> void:
	# Apply gravity if the player is not on the floor.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	direction_input = Input.get_axis("move_left", "move_right")
	set_is_jumping_inputs()
	set_is_wall_sliding_input()
	
	# Handle jump input when the player is on the floor.
	if is_wall_jumping:
		velocity.y = -jump_velocity
		# Determine wall side and apply horizontal force
		if get_wall_normal().x > 0:
			# Wall on the right, jump to the left
			velocity.x = wall_jump_velocity
		else:
			# Wall on the left, jump to the right
			velocity.x = -wall_jump_velocity
	elif is_floor_jumping:
		velocity.y = -jump_velocity
	elif is_wall_sliding:
		velocity.y = min(velocity.y, wall_slide_speed)
	elif direction_input:
		if is_on_floor():
			velocity.x = direction_input * max_speed
		else:
			velocity.x = clamp(velocity.x + direction_input * acceleration * delta, -max_speed, max_speed)
	elif is_on_floor():
		velocity.x = 0
	else:
		# Apply air resistance to slow down slightly when no input is given
		velocity.x = move_toward(velocity.x, 0, air_resistance * delta)
	
	move_and_slide()
	


func get_is_pointing_to_wall():
	return (get_wall_normal().x > 0 and direction_input > 0) or (get_wall_normal().x < 0 and direction_input > 0)

func set_is_wall_sliding_input() -> void:
	if is_floor_jumping || is_wall_jumping || is_on_floor():
		is_wall_sliding = false
	elif is_on_wall() and get_is_pointing_to_wall():
		is_wall_sliding = true
	else:
		is_wall_sliding = false
		
		
	

func set_is_jumping_inputs() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			is_floor_jumping = true
		
		elif is_on_wall():
			is_wall_jumping = true
	else:
		is_floor_jumping = false
		is_wall_jumping = false
