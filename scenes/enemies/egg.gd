extends Bullet

@export var spawn_scene : PackedScene

func _on_body_shape_entered_egg(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	has_hit_something = true
	animSprite.play("explode")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animSprite.animation == "explode":
		SignalBus.spawn_enemy.emit(spawn_scene, global_position, rotation, null)
		queue_free()
		
