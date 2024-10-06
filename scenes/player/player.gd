extends CharacterBody2D
class_name Player


#inputs
@onready var direction_input: float = 0.0

#actions
@onready var is_floor_jumping: bool = false
@onready var is_wall_jumping: bool = false
@onready var is_wall_sliding: bool = false

#states
@onready var is_running = false
@onready var is_in_air = false
@onready var is_idle = false
@onready var is_dead: bool = false

@export var lower_body_sprite: AnimatedSprite2D
@export var velocity_component: VelocityComponent

@onready var wall_grace_timer = 0.0  # Timer for wall grace period
@export var wall_grace_period: float = 0.2

func _ready() -> void:
	PlayerManager.set_player(self)

func _process(delta: float) -> void:
	if is_dead:
		PlayerManager.remove_current_player()
		queue_free()
	
	var left_right_input = get_left_right_input()
	#is looking right
	if is_on_wall() or is_wall_sliding:
		if get_wall_normal().x < 0:
			lower_body_sprite.flip_h = true
		else:
			lower_body_sprite.flip_h = false
	else:
		if left_right_input == Vector2.LEFT:
			lower_body_sprite.flip_h = true
		elif left_right_input == Vector2.RIGHT:
			
			lower_body_sprite.flip_h = false
	
	if is_running and lower_body_sprite.animation != "running":
		lower_body_sprite.play("running")
	elif is_idle and lower_body_sprite.animation != "idle":
		
		lower_body_sprite.play("idle")
	elif is_wall_sliding and lower_body_sprite.animation != "wall_sliding":
		lower_body_sprite.play("wall_sliding")
	elif is_in_air and not is_on_wall() and lower_body_sprite.animation != "jump":
		lower_body_sprite.play("jump")
	

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	direction_input = Input.get_axis("move_left", "move_right")
	
	
	set_actions(delta)
	set_states()
	var left_right_input = get_left_right_input()
	
	
	if not is_on_floor():
		velocity_component.apply_gravity(delta)
	elif not is_wall_jumping and not is_floor_jumping:
		velocity_component.apply_hit_ground()
	if is_on_ceiling():
		velocity_component.apply_hit_cieling()
	
	if is_wall_jumping:
		var wall_jumping_direction = Vector2.LEFT
		if get_wall_normal().x > 0:
			wall_jumping_direction = Vector2.RIGHT
		velocity_component.apply_wall_jump(wall_jumping_direction)
	elif is_floor_jumping:
		#is floor jumping
		velocity_component.apply_floor_jump()
	elif is_wall_sliding:
		#is wall sliding
		velocity_component.apply_wall_slide()
	elif is_running:
		velocity_component.apply_move(left_right_input, delta)
	elif is_in_air:
		velocity_component.apply_in_air_movement(direction_input, delta)
	
	elif is_idle:
		velocity_component.apply_idle(delta)
	
	velocity_component.do_character_move(self)
	


func get_is_pointing_to_wall():
	var return_val = (get_wall_normal().x < 0 and direction_input > 0) or (get_wall_normal().x > 0 and direction_input < 0)
	return return_val

func set_actions(delta: float) -> void:
	 # Update wall grace timer
	if is_on_wall():
		wall_grace_timer = 0.0  # Reset the timer if on the wall
	else:
		wall_grace_timer += delta
	# Apply gravity if the player is not on the floor
	
	if is_floor_jumping || is_wall_jumping || is_on_floor():
		is_wall_sliding = false
	elif is_on_wall() and get_is_pointing_to_wall():
		is_wall_sliding = true
	else:
		is_wall_sliding = false
	#Jumping inputs
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			is_floor_jumping = true
		
		elif is_on_wall() or wall_grace_timer <= wall_grace_period:
			is_wall_jumping = true
	else:
		is_floor_jumping = false
		is_wall_jumping = false
		
func set_states() -> void:
	if is_on_floor() and direction_input:
		is_running = true
	else:
		is_running = false
	
	if not is_on_floor() and not is_on_wall():
		is_in_air = true
	else:
		is_in_air = false
	
	if  is_on_floor() and not is_running:
		is_idle = true
	else:
		is_idle = false

func get_left_right_input() -> Vector2: 
	var left_right_input = Vector2.ZERO
	if direction_input > 0:
		left_right_input = Vector2.RIGHT
	elif direction_input < 0:
		left_right_input = Vector2.LEFT
	
	return left_right_input

func _on_died() -> void:
	print("you died")
	is_dead = true
	pass # Replace with function body.


func _on_damage_applied() -> void:
	print("damage")
	pass # Replace with function body.
