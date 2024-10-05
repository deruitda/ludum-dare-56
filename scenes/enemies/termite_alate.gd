extends CharacterBody2D

@onready var is_dead: bool = false
@export var velocity_component: VelocityComponent
@export var path_finder: PathFinder
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead:
		queue_free()
	pass
	
func _physics_process(delta: float) -> void:
	if PlayerManager.current_player:
		var direction = path_finder.get_direction_to_node(PlayerManager.current_player)
		velocity_component.apply_fly(direction)
		velocity_component.do_character_move(self)
	pass


func _on_health_component_died() -> void:
	is_dead = true
	pass # Replace with function body.
