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

@onready var _rage_speed: float = 500.0
@onready var _walk_speed: float = 200.0

@onready var is_dying: bool = false

@onready var spawn_point: SpawnPoint

func _ready() -> void:
	if start_walking_up:
		enemy_walk_direction.set_current_direction(Vector2.LEFT)
	else:
		enemy_walk_direction.set_current_direction(Vector2.RIGHT)
	
	
func _process(delta: float) -> void:
	
	if GameState.game_is_paused:
		return
	if enemy_walk_direction.current_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
		rage_ray.rotation = deg_to_rad(-90)
	elif enemy_walk_direction.current_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
		rage_ray.rotation = deg_to_rad(90)
	
	if is_dying:
		return
	elif animated_sprite_2d.animation == "walking" and is_raging:
		animated_sprite_2d.play("raging")
	elif animated_sprite_2d.animation == "raging" and not is_raging:
		animated_sprite_2d.play("walking")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GameState.game_is_paused:
		return
	if is_dying:
		velocity_component.set_rotation(0.0)
		velocity_component.apply_gravity(delta)
	else:
		velocity_component.set_rotation(rotation)
		handle_apply_movement(delta)
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

func handle_apply_movement(delta: float) -> void:
	
	if player_is_in_rage_view():
		is_raging = true
		velocity_component.max_speed = _rage_speed
	else:
		is_raging = false
		velocity_component.max_speed = _walk_speed
	
	
	if not is_on_floor() and not is_on_wall() and not is_on_ceiling():
		velocity_component.apply_gravity(delta)
		
	if (is_on_wall() and is_on_floor()) || (is_on_wall() and is_on_ceiling()):
		enemy_walk_direction.toggle_current_direction()
		toggle_direction_timer.start()
	
	velocity_component.apply_move(enemy_walk_direction.current_direction, delta)
	velocity_component.do_character_move(self)
	
func _on_health_component_died() -> void:
	start_death()
	SignalBus.enemy_died.emit(self)

	pass # Replace with function body.
func start_death():
	is_dying = true
	$BugAudio.play_enemy_death_audio()
	animated_sprite_2d.play("dying")
	animated_sprite_2d.animation_finished.connect(finish_death)

func finish_death() -> void:
	queue_free()
	pass # Replace with function body.


func _on_edge_detector_on_hanging_off_ground() -> void:
	enemy_walk_direction.toggle_current_direction()
	pass # Replace with function body.
