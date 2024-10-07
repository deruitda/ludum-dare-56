extends Node2D
class_name GrenadeLauncher

@onready var cooldown_finished_audio: AudioStreamPlayer2D = $CooldownFinishedAudio
@onready var click_when_cooling_down_audio: AudioStreamPlayer2D = $ClickWhenCoolingDownAudio
@onready var grenade_launch_audio: AudioStreamPlayer2D = $GrenadeLaunchAudio

@onready var grenade_charge_start_audio: AudioStreamPlayer2D = $GrenadeChargeStartAudio
@onready var grenade_charge_full_audio: AudioStreamPlayer2D = $GrenadeChargeFullAudio

@onready var path_finder: PathFinder = $PathFinder

@export var grenade_scene: PackedScene
@export var initial_velocity: float = 300.0  # Adjusted to a more realistic base velocity for a grenade

@onready var charging_amount: float = 0.0
@export var max_additional_velocity: float = 700.0  # Reasonable increase in speed when charged
@export var max_charge_time: float = 1.0  # Maximum seconds to fully charge the grenade

@export var progress_bar: ProgressBar  # Reference to the ProgressBar node
@export var cooldown_timer: Timer

@onready var full_charge_has_played: bool = false
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
	cooldown_finished_audio.play()
	

func charge_grenade(delta: float):
	if is_cooling_down:
		cooldown_finished_audio.play()
		return
	# Show the progress bar when charging begins
	if charging_amount == 0.0:
		progress_bar.visible = true
		grenade_charge_start_audio.play()

	# Increment the charging amount based on delta time, clamping it to the max charge time
	charging_amount = clamp(charging_amount + (delta / max_charge_time), 0, 1.0)
	if not full_charge_has_played and charging_amount == max_charge_time:
		grenade_charge_full_audio.play()
		full_charge_has_played = true
	# Update the progress bar's value
	progress_bar.value = charging_amount * progress_bar.max_value  # Set progress based on charge amount

func launch_grenade_toward(position: Vector2) -> void:
	if is_cooling_down:
		cooldown_finished_audio.play()
		return
	if charging_amount == 0.0:
		return
	var grenade = grenade_scene.instantiate()
	grenade.global_position = global_position
	var direction = path_finder.get_direction_to_position(position)

	# Calculate the final initial velocity based on charge percentage
	grenade.initial_velocity = direction.normalized() * (initial_velocity + (charging_amount * max_additional_velocity))
	BulletSpawner.create_grenade(grenade)

	# Reset the charging amount and hide the progress bar after launching
	charging_amount = 0.0  
	full_charge_has_played = false
	progress_bar.visible = false  # Hide the progress bar after launch
	is_cooling_down = true
	grenade_launch_audio.play()
	cooldown_timer.start()
