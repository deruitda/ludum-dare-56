extends CharacterBody2D
class_name Player

@onready var direction_input: float = 0.0

@onready var is_floor_jumping: bool = false
@onready var is_wall_jumping: bool = false
@onready var is_wall_sliding: bool = false

@onready var is_dead: bool = true

@export var lower_body_sprite: Sprite2D
@export var velocity_component: VelocityComponent

@onready var wall_grace_timer = 0.0  # Timer for wall grace period
@export var wall_grace_period: float = 0.2



func _physics_process(delta: float) -> void:
	# Apply gravity if the player is not on the floor
 # Update wall grace timer
	if is_on_wall():
		wall_grace_timer = 0.0  # Reset the timer if on the wall
	else:
		wall_grace_timer += delta
		
	if not is_on_floor():
		velocity_component.apply_gravity(delta)
	
	direction_input = Input.get_axis("move_left", "move_right")
	
	var left_right_input = Vector2.ZERO
	if direction_input > 0:
		left_right_input = Vector2.RIGHT
	elif direction_input < 0:
		left_right_input = Vector2.LEFT
	
		
	set_is_jumping_inputs()
	set_is_wall_sliding_input()
	
	if is_wall_jumping:
		var wall_jumping_direction = Vector2.LEFT
		if get_wall_normal().x > 0:
			wall_jumping_direction = Vector2.RIGHT
		velocity_component.apply_wall_jump(wall_jumping_direction)
	elif is_floor_jumping:
		velocity_component.apply_floor_jump()
	elif is_wall_sliding:
		velocity_component.apply_wall_slide()
	elif direction_input:
		if is_on_floor():
			velocity_component.apply_run(left_right_input)
		else:
			velocity_component.apply_in_air_movement(direction_input, delta)
	elif is_on_floor():
		velocity_component.apply_idle(delta)
	else:
		velocity_component.apply_in_air_idle(delta)
	
	velocity_component.do_character_move(self)
	
	#is looking right
	if left_right_input == Vector2.LEFT:
		lower_body_sprite.flip_v = true
	elif left_right_input == Vector2.RIGHT:
		lower_body_sprite.flip_v = false


func get_is_pointing_to_wall():
	var return_val = (get_wall_normal().x < 0 and direction_input > 0) or (get_wall_normal().x > 0 and direction_input < 0)
	return return_val

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
		
		elif is_on_wall() or wall_grace_timer <= wall_grace_period:
			is_wall_jumping = true
	else:
		is_floor_jumping = false
		is_wall_jumping = false


func _on_died() -> void:
	print("you died")
	is_dead = true
	queue_free()
	pass # Replace with function body.


func _on_damage_applied() -> void:
	print("damage")
	pass # Replace with function body.
