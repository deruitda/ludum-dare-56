extends Node
class_name DashComponent

@onready var is_dashing: bool = false
@onready var dash_direction: Vector2 = Vector2.ZERO
@export var dash_speed: float = 2000.0
@export var dash_timer: Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func do_dash(character_body: CharacterBody2D):
	character_body.velocity = dash_speed * dash_direction.normalized()
	character_body.move_and_slide()


func start_dash(new_dash_direction: Vector2):
	if not is_dashing:
		is_dashing = true
		dash_direction = new_dash_direction
		dash_timer.start()
		dash_timer.timeout.connect(_on_dash_timer_timeout)

func _on_dash_timer_timeout() -> void:
	dash_direction = Vector2.ZERO
	is_dashing = false
	
