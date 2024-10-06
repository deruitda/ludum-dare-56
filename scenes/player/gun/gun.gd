extends Node2D
class_name Gun

@export var muzzle: Muzzle
@export var bullet_packed_scene: PackedScene
@export var shooting_cooldown: Timer
@export var animated_sprite_2d: AnimatedSprite2D
@export var gun_shooting_audio: AudioStreamPlayer2D

var is_enabled = true
var is_cooling_down: bool = false
func shoot_bullet():
	if is_enabled and not is_cooling_down:
		start_cooldown()
		muzzle.create_bullet(bullet_packed_scene)
		gun_shooting_audio.play()
	
func disable() -> void:
	is_enabled = false

func start_cooldown() -> void:
	is_cooling_down = true
	shooting_cooldown.start()


func _on_shooting_cooldown_timeout() -> void:
	is_cooling_down = false


func set_flip_v(flip_val: bool) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.flip_v = flip_val
