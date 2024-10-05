extends Node
class_name HealthComponent
@export var max_health: int = 1

@onready var current_health: int
@onready var has_emitted_is_dead: bool = false
signal died
signal damage_applied

func _ready() -> void:
	current_health = max_health
	pass # Replace with function body.

func apply_damage(damage: int) -> void:
	current_health -= damage
	damage_applied.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not has_emitted_is_dead and is_dead():
		handle_dying()
	pass

func handle_dying() -> void:
	has_emitted_is_dead = true
	died.emit()
	

func is_dead() -> bool:
	return current_health <= 0

func apply_heal(added_health: int) -> void:
	current_health = min(current_health + added_health, max_health)
