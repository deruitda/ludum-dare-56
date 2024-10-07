extends Node2D
@onready var path_finder: PathFinder = $PathFinder

@export var grenade_scene: PackedScene
@export var initial_velocity: float = 300.0  # Adjusted to a more realistic base velocity for a grenade

@onready var charging_amount: float = 0.0
@export var max_additional_velocity: float = 700.0  # Reasonable increase in speed when charged
@export var max_charge_time: float = 1.0  # Maximum seconds to fully charge the grenade

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func charge_grenade(delta: float):
	# Increment the charging amount based on delta time, clamping it to the max charge time
	charging_amount = clamp(charging_amount + (delta / max_charge_time), 0, 1.0)  

func launch_grenade_toward(position: Vector2) -> void:
	var grenade = grenade_scene.instantiate()
	grenade.global_position = global_position
	var direction = path_finder.get_direction_to_position(position)
	
	# Calculate the final initial velocity based on charge percentage
	grenade.initial_velocity = direction.normalized() * (initial_velocity + (charging_amount * max_additional_velocity))
	BulletSpawner.create_grenade(grenade)
	
	charging_amount = 0.0  # Reset charging amount after launching
