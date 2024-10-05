extends Node2D
class_name Gun

@export var bullet_packed_scene: PackedScene
@export var muzzle_position: Node2D

@onready var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot_bullet():
	var new_bullet_position = muzzle_position.global_position
	var mouse_pos = get_global_mouse_position()
	# Calculate the direction from the player to the mouse position
	var direction = (mouse_pos - new_bullet_position).normalized()
	
	var new_bullet = bullet_packed_scene.instantiate() as Bullet
	new_bullet.global_position = new_bullet_position
	new_bullet.set_direction(direction)
	SignalBus.create_bullet.emit(new_bullet)
