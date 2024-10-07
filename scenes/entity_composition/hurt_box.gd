extends Area2D
class_name HurtBox

@export var health_component: HealthComponent

signal hit_by_bullet(bullet: Bullet)
signal hit_by_enemy()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func can_handle_taking_damage() -> bool:
	return not health_component.is_dead()

func handle_bullet_collision(bullet: Bullet):
	if not bullet.has_hit_something and not health_component.is_invulnerable():
		health_component.apply_damage(bullet.damage_per_bullet)
		hit_by_bullet.emit(bullet)

func handle_enemy_collision(enemy: HurtBox):
	if enemy.can_handle_taking_damage() and not health_component.is_invulnerable():
		health_component.apply_damage(1)
		hit_by_enemy.emit()

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet = area as Bullet
		handle_bullet_collision(bullet)
	else:
		var enemy = area as HurtBox
		handle_enemy_collision(enemy)
