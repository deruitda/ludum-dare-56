extends Camera2D

@export var follow_target: Node2D
@export_range(0, 1) var weight: float
var min_y_pos: float = -450

func _process(delta: float) -> void:
	
	if !follow_target:
		return
	
	global_position.y = lerp(global_position.y, follow_target.global_position.y, weight)
	
	if global_position.y > min_y_pos:
		global_position.y = min_y_pos
