extends CharacterBody2D
class_name TermiteAlate
@onready var is_dead: bool = false
@export var velocity_component: VelocityComponent
@export var path_finder: PathFinder
@export var gun: Gun
@export var gun_pivot: GunPivot
@onready var animSprite = $AnimatedSprite2D
@onready var hurt_box: HurtBox = $HurtBox

func _physics_process(delta: float) -> void:
	
	if is_dead:
		velocity_component.apply_gravity(delta)
	
	elif PlayerManager.current_player:
		var direction = path_finder.get_direction_to_node(PlayerManager.current_player)
		velocity_component.apply_move(direction, delta)
		gun_pivot.rotate_toward_direction(direction)
		gun.shoot_bullet()
		
	velocity_component.do_character_move(self)

func start_death() -> void:
	is_dead = true
	hurt_box.queue_free()
	$AudioManager.play_enemy_death_audio()
	gun.disable()
	animSprite.animation_finished.connect(anim_finished)
	animSprite.play("death")
	
func finish_death() -> void:
	queue_free()

func anim_finished():
	if animSprite.animation == "death":
		finish_death()
		
	if animSprite.animation == "attack":
		animSprite.play("idle")

func _on_health_component_died() -> void:
	SignalBus.enemy_died.emit()
	start_death()

func _on_shooting_timer_timeout() -> void:
	if PlayerManager.current_player:
		var direction = path_finder.get_direction_to_node(PlayerManager.current_player)
		gun_pivot.rotate_toward_direction(direction)
		gun.shoot_bullet()
		#animSprite.play("attack") -- this animation needs to be fixed so that the insect still flaps its wings
	pass # Replace with function body.
