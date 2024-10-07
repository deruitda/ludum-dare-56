extends Node2D
class_name Checkpoint

@export var area_2ds: Array[Area2D]
@onready var has_entered: bool = false
@onready var spawn_location: Node2D = $SpawnLocation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for area_2d in area_2ds:
		area_2d.set_collision_layer_value(10, true)
		area_2d.set_collision_mask_value(1, true)
		area_2d.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	has_entered = true
	SignalBus.set_new_checkpoint.emit(self)
	for area_2d in area_2ds:
		area_2d.queue_free()

func get_spawn_position() -> Vector2:
	return spawn_location.global_position
