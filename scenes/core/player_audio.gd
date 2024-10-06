extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
signal finished

const PlayerDeathAudio = [
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath1.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath2.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath3.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath4.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath5.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath6.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath7.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath8.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath9.wav",
	"res://assets/Audio/SFX/PlayerDeath/PlayerDeath10.wav"
]

	
func play_player_death_audio():
	var rand_death = PlayerDeathAudio.pick_random()
	audio_stream_player_2d.stream = load(rand_death)
	audio_stream_player_2d.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_2d_finished() -> void:
	finished.emit()
	pass # Replace with function body.
