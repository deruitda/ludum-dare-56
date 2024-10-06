extends CharacterBody2D
class_name TermiteSoldier
@onready var velocity_component: VelocityComponent = $VelocityComponent

@onready var enemy_walk_direction: EnemyWalkDirection = $EnemyWalkDirection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var toggle_direction_timer: Timer = $EnemyWalkDirection/ToggleDirectionTimer
@onready var rage_ray: RayCast2D = $RageRay

@onready var is_raging: bool = false
@export var wall_is_right: bool = true
@export var start_walking_up: bool = true

@onready var _rage_speed: float = 600.0
@onready var _walk_speed: float = 300.0

func _ready() -> void:
	if start_walking_up:
		enemy_walk_direction.set_current_direction(Vector2.UP)
	else:
		enemy_walk_direction.set_current_direction(Vector2.DOWN)
	
	rotation = deg_to_rad(-90)
	if not wall_is_right:
		animated_sprite_2d.flip_v = true
	
	
func _process(delta: float) -> void:
	if enemy_walk_direction.current_direction == Vector2.ZERO:
		set_current_direction()
	elif enemy_walk_direction.current_direction == Vector2.UP:
		animated_sprite_2d.flip_h = false
		rage_ray.rotation = deg_to_rad(-90)
	elif enemy_walk_direction.current_direction == Vector2.DOWN:
		animated_sprite_2d.flip_h = true
		rage_ray.rotation = deg_to_rad(90)
	
	if animated_sprite_2d.animation == "walking" and is_raging:
		animated_sprite_2d.play("raging")
	elif animated_sprite_2d.animation == "raging" and not is_raging:
		animated_sprite_2d.play("walking")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player_is_in_rage_view():
		is_raging = true
		velocity_component.max_speed = _rage_speed
		
	else:
		is_raging = false
		velocity_component.max_speed = _walk_speed
	
	if is_on_wall() and (is_on_ceiling() || is_on_floor()):
		enemy_walk_direction.toggle_current_direction()
	
	if is_on_wall():
		velocity_component.apply_move(enemy_walk_direction.current_direction, delta)
	elif not is_on_wall():
		var wall_direction = Vector2.RIGHT
		if not wall_is_right:
			wall_direction = Vector2.LEFT
		velocity_component.apply_move(wall_direction, delta)
	velocity_component.do_character_move(self)
	
	pass
func set_current_direction() -> void:
	
	enemy_walk_direction.current_direction = Vector2.UP
	pass # Replace with function body.
func _on_died() -> void:
	queue_free()

func player_is_in_rage_view() -> bool:
	var collider = rage_ray.get_collider()
	if collider:
		return true
	return false

func _on_toggle_direction_timer_timeout() -> void:
	enemy_walk_direction.toggle_current_direction()
	pass # Replace with function body.
