extends CharacterBody2D
class_name TermiteLarvae


@export var velocity_component: VelocityComponent
@export var start_direction: Vector2 = Vector2.RIGHT

@export var toggle_direction_timer: Timer

@onready var current_direction: Vector2

func _ready() -> void:
	current_direction = start_direction
	toggle_direction_timer.autostart = false
	toggle_direction_timer.start()
	toggle_direction_timer.timeout.connect(_on_toggle_direction_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_on_wall() and not is_on_ceiling():
		velocity_component.apply_gravity(delta)
		
	if is_on_wall() and is_on_floor():
		toggle_current_direction()
	velocity_component.apply_run(current_direction)
	velocity_component.do_character_move(self)
	
	pass

func _on_died() -> void:
	queue_free()

func toggle_current_direction() -> void:
	if current_direction == Vector2.RIGHT:
		current_direction = Vector2.LEFT 
	else: 
		current_direction = Vector2.RIGHT


func _on_toggle_direction_timer_timeout() -> void:
	toggle_current_direction()
	toggle_direction_timer.start()
	pass # Replace with function body.
