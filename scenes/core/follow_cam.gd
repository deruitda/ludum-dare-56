extends Camera2D
class_name FollowCam
@export var follow_target: Node2D
@export_range(0, 1) var weight: float
@export var min_y_pos: float = -450
@export var min_x_pos: float = -223.891
@export var max_x_pos: float = 2045.525
@export var is_boss: bool = false

# dumb way for narrow scenes to keep camera centered
var narrow_level_x_pos: float = 799.833
var narrow_level_y_barrier: float = -1045.839

func _process(delta: float) -> void:
	
	if !follow_target:
		return
	
	global_position = lerp(global_position, follow_target.global_position, weight)
	
	if !is_boss and global_position.y > narrow_level_y_barrier:
		global_position.x = narrow_level_x_pos
		return
	
	if global_position.x < min_x_pos:
		global_position.x = min_x_pos
			
	if global_position.x > max_x_pos:
		global_position.x = max_x_pos
	
	if global_position.y > min_y_pos:
		global_position.y = min_y_pos

func switch_target(new_target: Node2D):
	follow_target = new_target
