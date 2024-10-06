extends CharacterBody2D
class_name TermiteSoldier
@onready var velocity_component: VelocityComponent = $VelocityComponent

@onready var enemy_walk_direction: EnemyWalkDirection = $EnemyWalkDirection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var toggle_direction_timer: Timer = $EnemyWalkDirection/ToggleDirectionTimer

func _ready() -> void:
	if rotation == 90:
		enemy_walk_direction.set_current_direction(Vector2.DOWN)
	else:
		enemy_walk_direction.set_current_direction(Vector2.UP)
		
	
func _process(delta: float) -> void:
	if enemy_walk_direction.current_direction == Vector2.ZERO:
		set_current_direction()
	
	elif enemy_walk_direction.current_direction == Vector2.UP:
		animated_sprite_2d.flip_h = false
	elif enemy_walk_direction.current_direction == Vector2.DOWN:
		animated_sprite_2d.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_on_wall() and (is_on_ceiling() || is_on_floor()):
		enemy_walk_direction.toggle_current_direction()
	
	if is_on_wall():
		velocity_component.apply_move(enemy_walk_direction.current_direction, delta)
	elif not is_on_wall():
		var wall_direction = Vector2.RIGHT
		if enemy_walk_direction.current_direction == Vector2.DOWN:
			wall_direction = Vector2.LEFT
		velocity_component.apply_move(wall_direction, delta)
		print('not on wall')
		
	
	else: 
		print("nope")
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
