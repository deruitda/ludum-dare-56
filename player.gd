extends CharacterBody2D

@export var speed: float = 1000.0
@export var jump_velocity: float = 1000.0
@export var gravity: float = 2000.0  # Define a reasonable gravity value

func _physics_process(delta: float) -> void:
	# Apply gravity if the player is not on the floor.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump input when the player is on the floor.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity

	# Get horizontal movement direction.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Move the player with the updated velocity.
	move_and_slide()
