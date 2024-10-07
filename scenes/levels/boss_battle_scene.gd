extends Node2D

@onready var follow_cam: Camera2D = $FollowCam
@onready var termite_queen: ThermiteQueen = $TermiteQueen

@onready var time_before_explosion: Timer = $CutSceneTimers/TimeBeforeExplosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_termite_queen_queen_just_died() -> void:
	follow_cam.switch_target(termite_queen)
	time_before_explosion.start()
	time_before_explosion.timeout.connect(_on_time_before_explosion_timeout)
	pass # Replace with function body.

func _on_time_before_explosion_timeout() -> void:
	termite_queen.do_explode()
	pass
