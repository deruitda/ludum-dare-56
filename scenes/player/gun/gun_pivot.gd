extends Node2D
class_name GunPivot

@export var body_sprite: AnimatedSprite2D
@export var gun: Gun
@onready var mouse_pointing_input: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _set_flip(direction: Vector2):
		#is looking right
	var flip_val = false
	if direction.x < 0:
		flip_val = true
	
	if body_sprite:
		body_sprite.flip_h = flip_val
	if gun:
		gun.set_flip_v(flip_val)

func rotate_toward_direction(direction: Vector2):
	if direction.length() > 0:
		# Calculate the angle in radians
		var angle = direction.angle()
		# Set the rotation of the character
		rotation = angle
		_set_flip(direction)
		
func rotate_add_angle(angle_in_rads : float):
	rotation += angle_in_rads

func rotate_toward_position(point_to_global_position: Vector2):
	var direction = (point_to_global_position - global_position).normalized()
	rotate_toward_direction(direction)
	
func rotate_lerp_toward_position(point_to_global_position: Vector2):
	var direction = (point_to_global_position - global_position).normalized()
	var lerpAngle = lerp(direction, PlayerManager.current_player.global_position - global_position, 10).angle()
	var newAngle = move_toward(rotation, lerpAngle, 10)
	rotation = newAngle
