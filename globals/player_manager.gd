extends Node
@onready var current_player: Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove_current_player() -> void: 
	current_player = null

func set_player(new_player: Player) -> void:
	current_player = new_player
	current_player.health_component.current_health = GameState.current_player_health
	
