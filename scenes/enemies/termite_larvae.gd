extends CharacterBody2D
class_name TermiteLarvae

@export var velocity_component: VelocityComponent
@export var toggle_direction_timer: Timer
@onready var enemy_walk_direction: Node = $EnemyWalkDirection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_dead : bool = false

func _ready() -> void:
	set_current_direction()
	
func _process(delta: float) -> void:
	if enemy_walk_direction.current_direction == Vector2.ZERO:
		set_current_direction()
	
	if enemy_walk_direction.current_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif enemy_walk_direction.current_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
	
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
	
	pass
func set_current_direction() -> void:
	
	if is_on_floor() or is_on_ceiling():
		enemy_walk_direction.current_direction = Vector2.LEFT
	elif is_on_wall():
		enemy_walk_direction.current_direction = Vector2.UP
	pass # Replace with function body.
	
func _on_died() -> void:
	start_death()
	
func start_death() -> void:
	is_dead = true
	SignalBus.enemy_died.emit("larvae")
	animated_sprite_2d.animation_finished.connect(finish_death)
	animated_sprite_2d.play("death")
	
func finish_death() -> void:
	queue_free()



func _on_toggle_direction_timer_timeout() -> void:
	enemy_walk_direction.toggle_current_direction()
	pass # Replace with function body.
