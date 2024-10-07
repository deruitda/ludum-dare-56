extends Node2D
@onready var path_finder: PathFinder = $PathFinder

@export var grenade_scene: PackedScene
@onready var initial_velocity: Vector2 = Vector2(10000.0, 10000.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func launch_grenade_toward(position: Vector2) -> void:
	print("launch grenade")
	var grenade = grenade_scene.instantiate()
	grenade.global_position = global_position
	var direction = path_finder.get_direction_to_position(position)
	grenade.initial_velocity = direction.normalized() * initial_velocity
	BulletSpawner.create_grenade(grenade)
