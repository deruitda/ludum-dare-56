extends RigidBody2D

@onready var velocity_component: VelocityComponent = $VelocityComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity_component.apply_gravity(delta)


func _on_body_entered(body: Node) -> void:
	print ('on body entered')
	pass # Replace with function body.


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print ('on body shape entered')
	pass # Replace with function body.
