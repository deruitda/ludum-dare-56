extends Node2D
class_name BulletEmitter

@export var number_of_bullets: int = 6
@export var bullet_emit_timer: Timer
@export var muzzle: Muzzle
@export var bullet_packed_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_emit_timer.timeout.connect(_on_bullet_emit_timer)
	bullet_emit_timer.autostart = false
	bullet_emit_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_bullets() -> void:
	var angle_of_bullets = 360.0 / float(number_of_bullets)
	var current_bullet_direction = Vector2(cos(angle_of_bullets), sin(angle_of_bullets))
	for i in number_of_bullets:
		muzzle.create_bullet(bullet_packed_scene, current_bullet_direction)
		current_bullet_direction += Vector2(cos(angle_of_bullets), sin(angle_of_bullets))

func _on_bullet_emit_timer() ->void:
	create_bullets()
	bullet_emit_timer.start()
