extends Area2D
class_name HurtBox

@export var health_component: HealthComponent

signal hit_by_bullet(bullet: Bullet)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func can_handle_taking_damage() -> bool:
	return not health_component.is_dead()


func handle_bullet_collision(bullet: Bullet):
	health_component.apply_damage(bullet.damage_per_bullet)
	hit_by_bullet.emit(bullet)
	pass

func _on_area_entered(area: Area2D) -> void:
	var bullet = area as Bullet
	handle_bullet_collision(bullet)
