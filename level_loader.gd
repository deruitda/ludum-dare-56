extends Node2D
class_name LevelLoader

@export var current_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.start_game.connect(on_load_level) # Replace with function body.

func on_load_level() -> void:
	add_child(current_level.instantiate())
	print("hei")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
