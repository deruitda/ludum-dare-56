extends Node
class_name FlashingComponent

@export var flashable_body: Node2D
@export var health_component: HealthComponent
@export var invisible_time_in_seconds: float = 0.05
@export var visible_time_in_seconds: float = 0.3

@onready var invisible_timer: Timer 
@onready var visible_timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.is_invulnurable_state_change.connect(set_is_invulnerable)
	invisible_timer = Timer.new()
	invisible_timer.autostart = false
	invisible_timer.one_shot = true
	add_child(invisible_timer)
	invisible_timer.timeout.connect(_on_invisible_timer_timeout)

	
	visible_timer = Timer.new()
	visible_timer.autostart = false
	visible_timer.one_shot = true
	visible_timer.timeout.connect(_on_visible_timer_timeout)
	add_child(visible_timer)
	
	
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_is_invulnerable(is_invulnerable_new_value: bool) -> void:
	if is_invulnerable_new_value:
		start_invulnerable_visibility_cycle()
	else:
		stop_invulnerable_visibility_cycle()

func start_invulnerable_visibility_cycle():
	invisible_timer.start(invisible_time_in_seconds)
	flashable_body.visible = false
	pass
	
func stop_invulnerable_visibility_cycle():
	invisible_timer.stop()
	visible_timer.stop()
	flashable_body.visible = true
	pass

func _on_invisible_timer_timeout() -> void:
	flashable_body.visible = true
	visible_timer.start(visible_time_in_seconds)
	pass # Replace with function body.


func _on_visible_timer_timeout() -> void:
	flashable_body.visible = false
	invisible_timer.start(invisible_time_in_seconds)
	pass # Replace with function body.


func _on_health_component_is_invulnurable_state_change(is_invulnerable_new_value: bool) -> void:
	pass # Replace with function body.
