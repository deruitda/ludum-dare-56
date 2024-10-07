extends Area2D
class_name Bullet

@export var speed: float = 3000
@export var damage_per_bullet = 1
@export var animSprite : AnimatedSprite2D

@export var max_distance: float
@onready var distance_traveled: float = 0.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var direction: Vector2
@onready var has_hit_something = false
@onready var has_been_destroyed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if animSprite:
		animSprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
		if animSprite and animSprite.animation == "explode":
			has_been_destroyed = true
			queue_free()

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()

func _physics_process(delta: float) -> void:
	
	if GameState.game_is_paused:
		return
	if has_hit_something and (animSprite and not animSprite.animation == "explode"):
		animSprite.play("explode")

	elif not has_hit_something:
		var move_distance = direction * speed * delta
		position += move_distance
		
		# Update the distance traveled
		distance_traveled += move_distance.length()
		
		# Check if the bullet has exceeded the max distance
		if max_distance > 0 and distance_traveled >= max_distance:
			_handle_hit_environment()  # Trigger the hit behavior
			queue_free()  # Destroy the bullet if it has traveled too far

func _handle_hit_environment():
	has_hit_something = true
	collision_shape_2d.disabled = true
	
func _handle_hit_hurt_box():
	has_hit_something = true
	collision_shape_2d.disabled = true

func _on_area_entered(area: Area2D) -> void:
	_handle_hit_hurt_box()
	pass # Replace with function body.

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	_handle_hit_environment()
	pass # Replace with function body.
