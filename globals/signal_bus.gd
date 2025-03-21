extends Node

signal player_health_changed(new_health_value: int)

signal player_died()

signal start_game()

signal game_over()

signal create_bullet(bullet: Bullet)

signal equip_item(new_texture)

signal spawn_enemy(scene: PackedScene, location: Vector2, rotation: float, spawn_point: SpawnPoint)

signal enemy_died(enemy: Node)

signal set_new_checkpoint(new_checkpoint: Checkpoint)

signal opening_cutscene_finished()

signal set_game_is_paused_state(new_game_is_paused_value: bool)

signal termite_queen_is_dead

signal start_boss_scene

signal go_to_main_menu

signal pause_background_music

signal set_background_music(new_background_stream: AudioStream)

signal game_state_changed

signal boss_hurt

signal game_time_change(time_elapsed: float)
