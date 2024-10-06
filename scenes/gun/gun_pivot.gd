extends Node2D
class_name GunPivot

@export var gun: Gun
@export var upper_body_sprite: AnimatedSprite2D
@onready var mouse_pointing_input: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_mouse_pointing_input()
	rotate_to_mouse(mouse_pointing_input)
	
		#is looking right
	if mouse_pointing_input.x < 0:
		upper_body_sprite.flip_h = true
	elif mouse_pointing_input.x > 0: 
		upper_body_sprite.flip_h = false
	
	if Input.is_action_just_pressed("shoot"):
		gun.shoot_bullet(mouse_pointing_input)
	

func set_mouse_pointing_input() -> void:
	var mouse_pos = get_global_mouse_position()
	mouse_pointing_input = (mouse_pos - global_position).normalized()
	
func rotate_to_mouse(direction: Vector2):
	if direction.length() > 0:
		# Calculate the angle in radians
		var angle = direction.angle()
		# Set the rotation of the character
		rotation = angle
