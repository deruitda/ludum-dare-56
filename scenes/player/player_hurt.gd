extends AudioStreamPlayer2D


const PlayerHurtAudio = [
	"res://assets/Audio/SFX/PlayerHurt/PlayerHurt1.wav",
	"res://assets/Audio/SFX/PlayerHurt/PlayerHurt2.wav",
	"res://assets/Audio/SFX/PlayerHurt/PlayerHurt3.wav",
	"res://assets/Audio/SFX/PlayerHurt/PlayerHurt4.wav",
	"res://assets/Audio/SFX/PlayerHurt/PlayerHurt5.wav",
]

	
func play_player_hurt_audio():
	var rand_hurt = PlayerHurtAudio.pick_random()
	stream = load(rand_hurt)
	play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_2d_finished() -> void:
	finished.emit()
	pass # Replace with function body.
