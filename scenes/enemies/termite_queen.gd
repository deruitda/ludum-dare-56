extends Node2D
class_name ThermiteQueen

@onready var thorax: AnimatedSprite2D = $Model/Thorax
@onready var termite_queen_gun: ThermiteQueenGun = $GunPivot/TermiteQueenGun
@onready var gun_pivot: GunPivot = $GunPivot
@onready var stream_timer: Timer = $StreamTimer
@onready var cool_down_timer: Timer = $CoolDownTimer
@onready var bullet_emitter: BulletEmitter = $Emitters/BulletEmitter
@onready var blast_wave_timer: Timer = $BlastWaveTimer
@onready var egg_wave_timer: Timer = $EggWaveTimer
@onready var health_component: HealthComponent = $HealthComponent

@onready var explosion_delay_for_head_timer: Timer = $ExplosionDelayForHeadTimer
@onready var explosion_total_time_timer: Timer = $ExplosionTotalTimeTimer

@export var egg_scene : PackedScene
@export var num_blast_waves : int = 12
@export var num_egg_waves : int = 5
@export var emitters : Array[BulletEmitter]
@export var egg_muzzles : Array[Muzzle]

var current_blast_wave : int = 0
var current_egg_wave : int = 0
var is_cooling_down : bool = false
var is_attacking : bool = false

const attacks = [
	"egg",
	"stream",
	"blast"
]

var last_attack : String

signal queen_just_died
signal queen_explosion_finished

func _physics_process(delta: float) -> void:
	if GameState.game_is_paused:
		return
	rotate_toward_player(delta)
	
	if !is_attacking and !is_cooling_down:
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

	next = "egg"
	
	if next == last_attack:
		while next == last_attack:
			next = attacks.pick_random()
	
	return next
	
func egg_attack() -> void:
	termite_queen_gun.play_attack_anim()
	egg_wave_timer.start()

func stream_attack() -> void:
	termite_queen_gun.play_attack_anim()
	stream_timer.start()
	termite_queen_gun.shoot_stream()

func blast_attack() -> void:
	termite_queen_gun.play_attack_anim()
	blast_wave_timer.start()

func rotate_toward_player(delta: float):
	if PlayerManager.current_player:
		gun_pivot.rotate_lerp_toward_position(PlayerManager.current_player.global_position)

func _on_stream_timer_end():
	termite_queen_gun.stop_stream()
	start_cooldown()
	
func start_cooldown():
	termite_queen_gun.play_idle_anim()
	is_cooling_down = true
	is_attacking = false
	cool_down_timer.start()

func _on_cool_down_timer_timeout() -> void:
	is_cooling_down = false


func _on_blast_wave_timer_timeout() -> void:
	if current_blast_wave < num_blast_waves:
		current_blast_wave += 1
		for emitter in emitters:
			emitter.create_bullets()
		blast_wave_timer.start()
	else:
		current_blast_wave = 0
		start_cooldown()


func _on_egg_wave_timer_timeout() -> void:
	if current_egg_wave < num_egg_waves:
		var muz = egg_muzzles[current_egg_wave]
		muz.create_bullet(egg_scene)
		current_egg_wave += 1
		egg_wave_timer.start()
	else:
		current_egg_wave = 0
		start_cooldown()


func _on_area_2d_area_entered(area: Area2D) -> void:
	health_component.apply_damage(1)


func _on_health_component_died() -> void:
	SignalBus.set_game_is_paused_state.emit(true)
	queen_just_died.emit()
	#queue_free()

func do_explode() -> void:
	print("do explode")
	thorax.play("explode")
	
	explosion_delay_for_head_timer.start()
	explosion_delay_for_head_timer.timeout.connect(_on_explosion_delay_for_head_timeout)
	
	explosion_total_time_timer.start()
	explosion_total_time_timer.timeout.connect(_on_thorax_animation_finish)
	
	explosion_total_time_timer
	
func _on_thorax_animation_finish():
	print('thorax ani')
	queen_explosion_finished.emit()
	pass

func _on_explosion_delay_for_head_timeout():
	termite_queen_gun.play_explode_anim()
	
