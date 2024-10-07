extends Node
class_name HealthComponent
@export var max_health: int = 1
@export var seconds_of_invulnerability_after_damage: float = 0.0

@onready var current_health: int
@onready var has_emitted_is_dead: bool = false

@onready var is_currently_invulnerable_after_damage: bool = false
@onready var seconds_after_latest_damage: float = 0.0

@export var dash_component: DashComponent
@export var respawn_component: RespawnComponent
signal died
signal damage_applied
signal is_invulnurable_state_change(is_invulnerable_new_value: bool)

func _ready() -> void:
	reset_health()
	pass # Replace with function body.

func apply_damage(damage: int) -> void:
	current_health -= damage
	damage_applied.emit()
	is_currently_invulnerable_after_damage = true
	is_invulnurable_state_change.emit(is_currently_invulnerable_after_damage)
	seconds_after_latest_damage = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_currently_invulnerable_after_damage:
		seconds_after_latest_damage += delta
		if seconds_after_latest_damage > seconds_of_invulnerability_after_damage:
			is_currently_invulnerable_after_damage = false
			is_invulnurable_state_change.emit(is_currently_invulnerable_after_damage)
			seconds_after_latest_damage = 0.0
		
	
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

func is_invulnerable() -> bool:
	if respawn_component and respawn_component.is_invulnerable:
		return true
	if dash_component and dash_component.is_dashing:
		return true
	else:
		return is_currently_invulnerable_after_damage

func reset_health() -> void:
	has_emitted_is_dead = false
	current_health = max_health
