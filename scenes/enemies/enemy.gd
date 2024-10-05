extends CharacterBody2D


@export var gravity: float = 2000.0 
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_died() -> void:
	queue_free()


func _on_hurt_box_hit_by_bullet(bullet: Bullet) -> void:
	pass # Replace with function body.
