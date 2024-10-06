extends Camera2D

@export var follow_target: Node2D
@export_range(0, 1) var weight: float
@export var cam_y_offset: float = 1000

func _process(delta: float) -> void:
	global_position.y = lerp(global_position.y, follow_target.global_position.y + cam_y_offset, weight)
	print(global_position)
