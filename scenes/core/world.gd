extends Node2D
class_name World

@export var current_level : PackedScene
const OPENING_SCENE = preload("res://scenes/levels/opening_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.start_game.connect(start_opening_cutscene) # Replace with function body.
	SignalBus.opening_cutscene_finished.connect(start_opening_cutscene)

func start_opening_cutscene():
	add_child(OPENING_SCENE.instantiate())

func on_load_level() -> void:
	add_child(current_level.instantiate())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
