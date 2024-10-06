extends CharacterBody2D

@onready var is_dead: bool = false
@export var velocity_component: VelocityComponent
@export var path_finder: PathFinder
@export var gun: Gun
@onready var animSprite = $AnimatedSprite2D
	
func _physics_process(delta: float) -> void:
	
	if is_dead:
		velocity_component.apply_gravity(delta)
	
	elif PlayerManager.current_player:
		var direction = path_finder.get_direction_to_node(PlayerManager.current_player)
		velocity_component.apply_move(direction, delta)
		
	velocity_component.do_character_move(self)

func start_death() -> void:
	is_dead = true
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
	start_death()

func _on_shooting_timer_timeout() -> void:
	if PlayerManager.current_player:
		var direction = path_finder.get_direction_to_node(PlayerManager.current_player)
		gun.shoot_bullet(direction)
		#animSprite.play("attack") -- this animation needs to be fixed so that the insect still flaps its wings
	pass # Replace with function body.
