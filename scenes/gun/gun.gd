extends Node2D
class_name Gun

@export var muzzle: Muzzle
@export var bullet_packed_scene: PackedScene

var is_enabled = true

func shoot_bullet(direction: Vector2):
	
	if is_enabled:
		$AudioStreamPlayer2D.play()
		muzzle.create_bullet(bullet_packed_scene, direction)
	
func disable() -> void:
	is_enabled = false
