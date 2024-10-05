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
	var angle_of_bullets = 360.0 / float(number_of_bullets)  # Divide 360 degrees by the number of bullets
	
	for i in range(number_of_bullets):
		# Calculate the current angle for this bullet (convert degrees to radians)
		var current_angle = deg_to_rad(i * angle_of_bullets)
		
		# Calculate the direction based on the angle
		var current_bullet_direction = Vector2(cos(current_angle), sin(current_angle))
		
		# Create the bullet at the muzzle with the calculated direction
		muzzle.create_bullet(bullet_packed_scene, current_bullet_direction)
func _on_bullet_emit_timer() ->void:
	create_bullets()
	bullet_emit_timer.start()
