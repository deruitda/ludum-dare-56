extends Node2D
class_name PathFinder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to get the direction from the current PathFinder node to the target node.
func get_direction_to_node(node: Node2D) -> Vector2:
	# Calculate the difference in positions
	var direction: Vector2 = node.global_position - global_position
	
	# Normalize the direction vector so it has a length of 1
	return direction.normalized()
