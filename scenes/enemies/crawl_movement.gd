extends Node2D
class_name TermiteAI

@export var enemy_walk_direction: Node
@export var animated_sprite_2d: AnimatedSprite2D

func _process(delta: float) -> void:
	if enemy_walk_direction.current_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif enemy_walk_direction.current_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false

func 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dead:
		velocity_component.apply_idle(delta)
		return
	
	if not is_on_floor() and not is_on_wall() and not is_on_ceiling():
		velocity_component.apply_gravity(delta)
		
	if (is_on_wall() and is_on_floor()) || (is_on_wall() and is_on_ceiling()):
		enemy_walk_direction.toggle_current_direction()
		toggle_direction_timer.start()
	
	velocity_component.apply_move(enemy_walk_direction.current_direction, delta)
	velocity_component.do_character_move(self)