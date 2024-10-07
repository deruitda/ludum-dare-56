extends CharacterBody2D

@onready var thorax: AnimatedSprite2D = $Model/Thorax
@onready var termite_queen_gun = $GunPivot/TermiteQueenGun
@onready var gun_pivot: GunPivot = $GunPivot
@onready var stream_timer: Timer = $StreamTimer
@onready var cool_down_timer: Timer = $CoolDownTimer
@onready var bullet_emitter: BulletEmitter = $Emitters/BulletEmitter
@onready var blast_wave_timer: Timer = $BlastWaveTimer

@export var num_blast_waves : int = 12
@export var emitters : Array[BulletEmitter]

var current_wave : int = 0
var is_cooling_down : bool = false
var is_attacking : bool = false

const attacks = [
	"egg",
	"stream",
	"blast"
]

var last_attack : String

func _physics_process(delta: float) -> void:
	rotate_toward_player(delta)
	
	if !is_attacking and !is_cooling_down:
		print("attacking")
		perform_attack()
	

func perform_attack() -> void:
	is_attacking = true
	var next = get_next_attack()
	last_attack = next
	match next:
		"egg":
			egg_attack()
		"stream":
			stream_attack()
		"blast":
			blast_attack()
func get_next_attack() -> String:
	var next = attacks.pick_random()
	
	if next == last_attack:
		while next == last_attack:
			next = attacks.pick_random()
	
	print("Next attack " + next)
	return next
	
func egg_attack() -> void:
	print("Incoming egg")
	start_cooldown()

func stream_attack() -> void:
	stream_timer.start()
	termite_queen_gun.shoot_stream()
	print("Incoming stream")

func blast_attack() -> void:
	blast_wave_timer.start()

func rotate_toward_player(delta: float):
	gun_pivot.rotate_lerp_toward_position(PlayerManager.current_player.global_position)

func _on_stream_timer_end():
	print("ending stream")
	termite_queen_gun.stop_stream()
	start_cooldown()
	
func start_cooldown():
	is_cooling_down = true
	is_attacking = false
	cool_down_timer.start()

func _on_cool_down_timer_timeout() -> void:
	is_cooling_down = false


func _on_blast_wave_timer_timeout() -> void:
	if current_wave < num_blast_waves:
		current_wave += 1
		for emitter in emitters:
			emitter.create_bullets()
		blast_wave_timer.start()
	else:	
		start_cooldown()
