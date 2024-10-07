extends Node2D
class_name SpawnPoint
@export var scene : PackedScene
@export var timer : Timer
@export var animSprite : AnimatedSprite2D
@export var spawn_range : int = 1000
@export var total_amount_of_enemies_allowed_at_a_time: int = 1

@export var spawn_location: Node2D

@onready var number_of_child_enemies_alive: int = 0

func _ready() -> void:
	timer.autostart = false
	timer.one_shot = false
	timer.start()
	timer.timeout.connect(_on_spawn_timer_timeout)
	
	animSprite.animation_finished.connect(_on_anim_finished)
	SignalBus.enemy_died.connect(_on_enemy_died)

func _on_spawn_timer_timeout() -> void:
	# play the 'spawn' animation, when that animation is complete it will trigger 
	# the _on_anim_finished callback to spawn the enemy scene
	if is_player_in_range() and number_of_child_enemies_alive < total_amount_of_enemies_allowed_at_a_time:
		animSprite.play("spawn")

func _on_anim_finished() -> void:
	if animSprite.animation == "spawn":
		_spawn_new_enemy()
		animSprite.play("idle")

func _spawn_new_enemy():
	position = global_position
	if spawn_location:
		position = spawn_location.global_position
		
	SignalBus.spawn_enemy.emit(scene, position, global_rotation, self)
	number_of_child_enemies_alive += 1
	if number_of_child_enemies_alive < total_amount_of_enemies_allowed_at_a_time:
		timer.start()
	

func is_player_in_range() -> bool:
	var player = PlayerManager.current_player
	
	if !player:
		return false
		
	var distance = player.global_position.distance_to(self.global_position)
	
	if distance < spawn_range:
		return true
		
	return false
	
func _on_enemy_died(enemy: Node):
	var spawn_point = enemy.spawn_point as SpawnPoint
	if spawn_point == self:
		number_of_child_enemies_alive -= 1
		if number_of_child_enemies_alive < total_amount_of_enemies_allowed_at_a_time and timer.is_stopped():
			timer.start()
