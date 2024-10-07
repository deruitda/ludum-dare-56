extends RigidBody2D
class_name Grenade

@onready var bullet_emitter: BulletEmitter = $BulletEmitter
@onready var explosion_timer: Timer = $ExplosionTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var initial_velocity: Vector2
@export var gravity: float = 980.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = initial_velocity
	explosion_timer.start()
	explosion_timer.timeout.connect(explode)
	# This ensures CCD is enabled for high-speed collisions
	set_continuous_collision_detection_mode(RigidBody2D.CCD_MODE_CAST_RAY)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func start_explosion_animation() -> void:
	animated_sprite_2d.play("explode")

func explode() -> void:
	
	if GameState.game_is_paused:
		return
	bullet_emitter.create_bullets()
	start_explosion_animation()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if GameState.game_is_paused:
		return
	explode()
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "explode":
		queue_free()
