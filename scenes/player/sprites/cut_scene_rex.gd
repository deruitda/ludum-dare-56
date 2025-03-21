extends Node2D
class_name CutSceneRex

@onready var walk_speed: float = 400.0
@onready var is_walking: bool = false
@onready var walking_direction: Vector2
@onready var is_shrinking: bool = false

@onready var target_scale: Vector2 = Vector2(0.35, 0.35)
@onready var shrink_speed = 2.0

@onready var original_scale: Vector2

@onready var collision_shape : CollisionShape2D = $Area2D/CollisionShape2D

signal done_shrinking
signal headphones_are_on

@onready var lower_body: AnimatedSprite2D = $LowerBody
@onready var upper_body: AnimatedSprite2D = $UpperBody

@onready var time_to_put_on_headphones: Timer = $TimeToPutOnHeadphones

@export var set_as_target_scale: bool = false
@export var has_headphones: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if set_as_target_scale:
		scale = target_scale
	if not has_headphones:
		upper_body.play("no_headphone_idle")
	else:
		upper_body.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_walking:
		position += Vector2.RIGHT * walk_speed * delta
	
	if is_shrinking:
		# Shrink while keeping the bottom aligned
		var scale_step = (target_scale - scale) * shrink_speed * delta
		scale += scale_step
		
		# Adjust position so that it shrinks towards the bottom
		#position.y -= scale_step.y * collision_shape.shape.extents.y
		
		# Stop shrinking when target size is reached
		if scale - target_scale < Vector2(0.15, 0.15):
			is_shrinking = false
			done_shrinking.emit()
			
	pass

func start_walk(new_direction: Vector2):
	is_walking = true
	walking_direction = new_direction
	lower_body.play("walking")
	
	
func stop_walk() -> void:
	is_walking = false
	lower_body.play("idle")

func put_on_headphones_and_shrink(new_original_scale: Vector2):
	original_scale = new_original_scale
	upper_body.play("put_on_headphones")
	time_to_put_on_headphones.start()
	time_to_put_on_headphones.timeout.connect(_on_time_to_put_on_headphones)
	upper_body.animation_finished.connect(_on_put_on_headphones_end)

func _on_time_to_put_on_headphones():
	headphones_are_on.emit()
	time_to_put_on_headphones.timeout.disconnect(_on_time_to_put_on_headphones)

func _on_put_on_headphones_end():
	set_is_shrinking()
	upper_body.animation_finished.disconnect(_on_put_on_headphones_end)
	has_headphones = true
	
func set_is_shrinking() -> void:
	is_shrinking = true
