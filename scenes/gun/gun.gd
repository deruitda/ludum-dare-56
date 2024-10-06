extends Node2D
class_name Gun

@export var muzzle: Muzzle
@export var bullet_packed_scene: PackedScene


func shoot_bullet(direction: Vector2):
	$AudioStreamPlayer2D.play()
	muzzle.create_bullet(bullet_packed_scene, direction)
