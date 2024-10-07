extends Node2D
class_name GrenadeLauncher
@onready var path_finder: PathFinder = $PathFinder

@export var grenade_scene: PackedScene
@export var initial_velocity: float = 300.0  # Adjusted to a more realistic base velocity for a grenade

@onready var charging_amount: float = 0.0
@export var max_additional_velocity: float = 700.0  # Reasonable increase in speed when charged
@export var max_charge_time: float = 1.0  # Maximum seconds to fully charge the grenade

@export var progress_bar: ProgressBar  # Reference to the ProgressBar node
@export var cooldown_timer: Timer

@onready var is_cooling_down: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.autostart = false
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	progress_bar.visible = false  # Hide the progress bar initially

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_cooldown_timer_timeout() -> void:
	is_cooling_down = false

func charge_grenade(delta: float):
	if is_cooling_down:
		return
	# Show the progress bar when charging begins
	if charging_amount == 0.0:
		progress_bar.visible = true

	# Increment the charging amount based on delta time, clamping it to the max charge time
	charging_amount = clamp(charging_amount + (delta / max_charge_time), 0, 1.0)

	# Update the progress bar's value
	progress_bar.value = charging_amount * progress_bar.max_value  # Set progress based on charge amount

func launch_grenade_toward(position: Vector2) -> void:
	if is_cooling_down:
		return
	var grenade = grenade_scene.instantiate()
	grenade.global_position = global_position
	var direction = path_finder.get_direction_to_position(position)

	# Calculate the final initial velocity based on charge percentage
	grenade.initial_velocity = direction.normalized() * (initial_velocity + (charging_amount * max_additional_velocity))
	BulletSpawner.create_grenade(grenade)

	# Reset the charging amount and hide the progress bar after launching
	charging_amount = 0.0  
	progress_bar.visible = false  # Hide the progress bar after launch
	is_cooling_down = true
	cooldown_timer.start()
