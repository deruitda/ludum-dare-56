extends RigidBody2D
class_name Grenade

@onready var initial_velocity: Vector2
@export var gravity: float = 980.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = initial_velocity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	print ('on body entered')
	pass # Replace with function body.


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print ('on body shape entered')
	pass # Replace with function body.
