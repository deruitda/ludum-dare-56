class_name Despawner
extends Node2D

signal despawn()
@export var despawn_distance : int = 3000
var is_despawned : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !PlayerManager.current_player:
		return
	
	var playerPos = PlayerManager.current_player.global_position
	var distance = playerPos.distance_to(self.global_position)
	
	if !is_despawned and distance > despawn_distance:
		print("emitting despawn")
		is_despawned = true
		despawn.emit()
