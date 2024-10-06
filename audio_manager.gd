extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const BugDeathAudio = [
	"res://assets/Audio/SFX/BugDeath1.wav",
	"res://assets/Audio/SFX/BugDeath2.wav",
	"res://assets/Audio/SFX/BugDeath3.wav",
	"res://assets/Audio/SFX/BugDeath4.wav",
	"res://assets/Audio/SFX/BugDeath5.wav"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.enemy_died.connect(_play_enemy_death_audio)
	
func _play_enemy_death_audio(name: String):
	var rand_death = BugDeathAudio.pick_random()
	audio_stream_player_2d.stream = load(rand_death)
	audio_stream_player_2d.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
