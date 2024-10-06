extends Node2D
class_name Gun

@export var muzzle: Muzzle
@export var bullet_packed_scene: PackedScene
@onready var shooting_cooldown: Timer = $ShootingCooldown

var is_enabled = true
var is_cooling_down: bool = false
func shoot_bullet():
	if is_enabled and not is_cooling_down:
		start_cooldown()
		muzzle.create_bullet(bullet_packed_scene)
		$AudioStreamPlayer2D.play()
	
func disable() -> void:
	is_enabled = false

func start_cooldown() -> void:
	is_cooling_down = true
	shooting_cooldown.start()


func _on_shooting_cooldown_timeout() -> void:
	is_cooling_down = false
