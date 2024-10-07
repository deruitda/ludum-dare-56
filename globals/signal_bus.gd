extends Node

signal player_hurt()

signal player_kill()

signal player_died()

signal start_game()

signal create_bullet(bullet: Bullet)

signal equip_item(new_texture)

signal spawn_enemy(scene: PackedScene, location: Vector2, rotation: float)

signal enemy_died(name: String)

signal set_new_checkpoint(new_checkpoint: Checkpoint)

signal opening_cutscene_finished()
