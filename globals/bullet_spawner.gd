extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.create_bullet.connect(create_bullet)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_bullet(bullet: Bullet) -> void:
	get_tree().root.add_child(bullet)
