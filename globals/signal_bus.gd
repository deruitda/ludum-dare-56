extends Node

signal player_health_changed(new_health_value: int)

signal player_died()

signal start_game()

signal create_bullet(bullet: Bullet)

signal equip_item(new_texture)

signal spawn_enemy(scene: PackedScene, location: Vector2, rotation: float, spawn_point: SpawnPoint)

signal enemy_died(enemy: Node)

signal set_new_checkpoint(new_checkpoint: Checkpoint)

signal opening_cutscene_finished()

signal set_game_is_paused_state(new_game_is_paused_value: bool)

signal termite_queen_is_dead

signal start_boss_scene
