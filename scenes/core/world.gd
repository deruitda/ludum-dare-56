extends Node2D
class_name World

@export var current_level : PackedScene
@export var skip_cutscene: bool = false
const OPENING_SCENE = preload("res://scenes/levels/opening_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if skip_cutscene:
		on_load_level()
	else:
		SignalBus.start_game.connect(start_opening_cutscene) # Replace with function body.
		SignalBus.opening_cutscene_finished.connect(on_load_level)

func start_opening_cutscene():
	clean_up_scene()
	add_child(OPENING_SCENE.instantiate())

func on_load_level() -> void:
	clean_up_scene()
	add_child(current_level.instantiate())
	
func clean_up_scene():
	for child in get_children():
		child.queue_free()  # Properly removes and frees memory
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
