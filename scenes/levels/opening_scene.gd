extends Node2D
@onready var rex: CutSceneRex = $Rex
@onready var wait_timer: Timer

@onready var background_music_audio = preload("res://assets/Audio/Music/Descent.wav")

var INITIAL_WALK_IN_TIME = 2.2
var INITIAL_IDLE_TIME = 2.0
var AFTER_IDLE_WALK_IN_TIME =  1.96
var IDLE_BEFORE_PUTTING_IN_HEADPHONES = 1.0
var IDLE_BEFORE_WALK_OUT = 1.0
var WALK_OUT_TIME = 1.0

@onready var help_text: RichTextLabel = $"Help Text"
@onready var retort_audio: AudioStreamPlayer = $RetortAudio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rex.start_walk(Vector2.RIGHT)
	wait_timer = Timer.new()
	add_child(wait_timer)
	wait_timer.wait_time = INITIAL_WALK_IN_TIME
	wait_timer.autostart = false
	wait_timer.one_shot = true
	wait_timer.start()
	wait_timer.timeout.connect(_on_end_walk_in_timer_timeout)
	
	SignalBus.pause_background_music.emit()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.

func _on_end_walk_in_timer_timeout() -> void:
	rex.stop_walk()
	wait_timer.timeout.disconnect(_on_end_walk_in_timer_timeout)
	help_text.show()
	wait_timer.wait_time = INITIAL_IDLE_TIME
	wait_timer.start()
	wait_timer.timeout.connect(start_retort_audio)

func start_retort_audio() -> void:
	wait_timer.timeout.disconnect(start_retort_audio)
	retort_audio.play()
	retort_audio.finished.connect(_on_wait_after_entering_house_timer_timeout)
	

func _on_wait_after_entering_house_timer_timeout() -> void:
	retort_audio.stop()
	retort_audio.finished.disconnect(_on_wait_after_entering_house_timer_timeout)
	
	rex.start_walk(Vector2.RIGHT)
	
	wait_timer.wait_time = AFTER_IDLE_WALK_IN_TIME
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
	rex.put_on_headphones_and_shrink(rex.scale)

func _on_rex_headphones_are_on() -> void:
	SignalBus.set_background_music.emit(background_music_audio)
	pass # Replace with function body.
	
func _on_rex_done_shrinking() -> void:
	wait_timer.timeout.connect(_on_rex_before_walking_walking_out_idle_timeout)
	wait_timer.wait_time = IDLE_BEFORE_WALK_OUT
	wait_timer.start()

func _on_rex_before_walking_walking_out_idle_timeout() -> void:
	wait_timer.timeout.disconnect(_on_rex_before_walking_walking_out_idle_timeout)
	wait_timer.timeout.connect(_on_done_walking_out_timeout)
	wait_timer.wait_time = WALK_OUT_TIME
	wait_timer.start()
	rex.start_walk(Vector2.RIGHT)
	
func _on_done_walking_out_timeout():
	wait_timer.timeout.disconnect(_on_done_walking_out_timeout)
	SignalBus.opening_cutscene_finished.emit()
