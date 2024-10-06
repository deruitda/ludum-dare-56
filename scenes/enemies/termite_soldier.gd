extends CharacterBody2D
class_name TermiteSoldier
@onready var velocity_component: VelocityComponent = $VelocityComponent

@onready var enemy_walk_direction: EnemyWalkDirection = $EnemyWalkDirection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var toggle_direction_timer: Timer = $EnemyWalkDirection/ToggleDirectionTimer

func _ready() -> void:
	enemy_walk_direction.set_current_direction(Vector2.UP)
	
func _process(delta: float) -> void:
	if enemy_walk_direction.current_direction == Vector2.ZERO:
		set_current_direction()
	
	elif enemy_walk_direction.current_direction == Vector2.UP:
		rotation = deg_to_rad(-90)
	elif enemy_walk_direction.current_direction == Vector2.DOWN:
		rotation = deg_to_rad(90)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_on_wall() and (is_on_ceiling() || is_on_floor()):
		enemy_walk_direction.toggle_current_direction()
	elif is_on_wall():
		velocity_component.apply_climb(enemy_walk_direction.current_direction, delta)
	elif not is_on_wall():
		var wall_direction = Vector2.RIGHT
		if enemy_walk_direction.current_direction == Vector2.DOWN:
			wall_direction = Vector2.LEFT
		velocity_component.apply_run(wall_direction, delta)
		print("tryna walk. wall normal: " + str(get_wall_normal()))
	else:
		print("NO")
	
	velocity_component.do_character_move(self)
	
	pass
func set_current_direction() -> void:
	
	enemy_walk_direction.current_direction = Vector2.UP
	pass # Replace with function body.
func _on_died() -> void:
	queue_free()



func _on_toggle_direction_timer_timeout() -> void:
	enemy_walk_direction.toggle_current_direction()
	pass # Replace with function body.
