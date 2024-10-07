extends Gun

var is_shooting : bool = false

func _physics_process(delta: float) -> void:
	if is_shooting:
		muzzle.create_bullet(bullet_packed_scene)

func shoot_stream():
	print("shooting")
	is_shooting = true


func stop_stream() -> void:
	print("stopping shooting")
	is_shooting = false

func play_attack_anim():
	animated_sprite_2d.play("attack")
	
func play_idle_anim():
	animated_sprite_2d.play("idle")
