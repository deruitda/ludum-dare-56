extends Node2D
@onready var rex: CutSceneRex = $Rex
@onready var wait_timer: Timer


var INITIAL_IDLE_TIME = 2.0
var IDLE_BEFORE_PUTTING_IN_HEADPHONES = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rex.start_walk(Vector2.RIGHT)
	wait_timer = Timer.new()
	add_child(wait_timer)
	wait_timer.wait_time = 1.0
	wait_timer.autostart = false
	wait_timer.one_shot = true
	wait_timer.start()
	wait_timer.timeout.connect(_on_end_walk_in_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.

func _on_end_walk_in_timer_timeout() -> void:
	rex.stop_walk()
	wait_timer.timeout.disconnect(_on_end_walk_in_timer_timeout)
	
	wait_timer.wait_time = INITIAL_IDLE_TIME
	wait_timer.start()
	wait_timer.timeout.connect(_on_wait_after_entering_house_timer_timeout)

func _on_wait_after_entering_house_timer_timeout() -> void:
	
	rex.start_walk(Vector2.RIGHT)
	wait_timer.timeout.disconnect(_on_wait_after_entering_house_timer_timeout)
	
	wait_timer.wait_time = 3.16
	wait_timer.start()
	wait_timer.timeout.connect(_on_end_walk_to_hole_timer_timeout)
	
func _on_end_walk_to_hole_timer_timeout() -> void:
	rex.stop_walk()
	wait_timer.timeout.disconnect(_on_end_walk_to_hole_timer_timeout)
	
	wait_timer.wait_time = IDLE_BEFORE_PUTTING_IN_HEADPHONES
	wait_timer.start()
	wait_timer.timeout.connect(_on_idle_before_shrink_timeout)
	pass
	
func _on_idle_before_shrink_timeout():
	wait_timer.timeout.disconnect(_on_idle_before_shrink_timeout)
	rex.set_is_shrinking(rex.scale)


func _on_rex_done_shrinking() -> void:
	wait_timer.timeout.connect(_on_done_walking_out_timeout)
	wait_timer.start()
	rex.start_walk(Vector2.RIGHT)

func _on_done_walking_out_timeout():
	wait_timer.timeout.disconnect(_on_done_walking_out_timeout)
	SignalBus.opening_cutscene_finished.emit()
