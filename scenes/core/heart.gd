extends Sprite2D
class_name HeartSprite
const HEART_FULL = preload("res://assets/sprites/ui/heart-full.png")
const HEART_EMPTY = preload("res://assets/sprites/ui/heart-empty.png")
@onready var is_heart_full: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_is_heart_full(new_is_heart_full: bool):
	is_heart_full = new_is_heart_full
	if is_heart_full:
		texture = HEART_FULL
	else:
		texture = HEART_EMPTY
