extends Gun
class_name ThermiteQueenGun
var is_shooting : bool = false

func _physics_process(delta: float) -> void:
	if is_shooting:
		muzzle.create_bullet(bullet_packed_scene)

func shoot_stream():
	is_shooting = true


func stop_stream() -> void:
	is_shooting = false

func play_attack_anim():
	animated_sprite_2d.play("attack")
	
func play_idle_anim():
	animated_sprite_2d.play("idle")

func play_explode_anim():
	animated_sprite_2d.play("explode")
