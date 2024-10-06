extends Node2D
class_name GunPivot

@export var body_sprite: AnimatedSprite2D
@onready var mouse_pointing_input: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _set_flip(direction: Vector2):
		#is looking right
	if body_sprite:
		if direction.x < 0:
			body_sprite.flip_h = true
		elif direction.x > 0: 
			body_sprite.flip_h = false

func rotate_toward_position(point_to_global_position: Vector2):
	var direction = (point_to_global_position - global_position).normalized()
	if direction.length() > 0:
		# Calculate the angle in radians
		var angle = direction.angle()
		# Set the rotation of the character
		rotation = angle
		_set_flip(direction)
