extends Node2D


@onready var invisible_timer: Timer = $InvisibleTimer
@onready var visible_timer: Timer = $VisibleTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_health_component_is_invulnurable_state_change(is_invulnerable_new_value: bool) -> void:
	if is_invulnerable_new_value:
		start_invulnerable_visibility_cycle()
	else:
		stop_invulnerable_visibility_cycle()

func start_invulnerable_visibility_cycle():
	invisible_timer.start()
	visible = false
	pass
	
func stop_invulnerable_visibility_cycle():
	invisible_timer.stop()
	visible_timer.stop()
	visible = true
	pass

func _on_invisible_timer_timeout() -> void:
	visible = true
	visible_timer.start()
	pass # Replace with function body.


func _on_visible_timer_timeout() -> void:
	visible = false
	invisible_timer.start()
	pass # Replace with function body.
