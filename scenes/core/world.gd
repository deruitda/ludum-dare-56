extends Node2D
class_name World

@export var current_level : PackedScene
@export var skip_cutscene: bool = false
@export var start_with_boss_fight = false
const OPENING_SCENE = "res://scenes/levels/opening_scene.tscn"
const END_CREDITS_SCENE = "res://scenes/core/game_over_menu.tscn"
const BOSS_FIGHT_SCENE = "res://scenes/levels/boss_battle_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.termite_queen_is_dead.connect(transition_to_end_credits_scene)
	if skip_cutscene:
		on_load_level()
	elif start_with_boss_fight:
		SignalBus.start_game.connect(transition_to_boss_scene) # Replace with function body.
	else:
		SignalBus.start_game.connect(start_opening_cutscene) # Replace with function body.
		SignalBus.opening_cutscene_finished.connect(on_load_level)
	
	SignalBus.go_to_main_menu.connect(_on_go_to_main_menu)

func start_opening_cutscene():
	clean_up_scene()
	add_child(preload(OPENING_SCENE).instantiate())

func on_load_level() -> void:
	clean_up_scene()
	add_child(current_level.instantiate())
	
func clean_up_scene():
	for child in get_children():
		child.queue_free()  # Properly removes and frees memory
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition_to_end_credits_scene() -> void:
	print("end credits?")
	clean_up_scene()
	add_child(preload(END_CREDITS_SCENE).instantiate())

func transition_to_boss_scene() -> void:
	clean_up_scene()
	add_child(preload(BOSS_FIGHT_SCENE).instantiate())

func _on_go_to_main_menu():
	clean_up_scene()
