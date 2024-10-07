extends AudioStreamPlayer

var prev_stream : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.pause_background_music.connect(_on_pause_background_music)
	SignalBus.set_background_music.connect(_on_set_background_music)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pause_background_music():
	stop()
	pass

func _on_set_background_music(new_stream: AudioStream):
	stream = new_stream
	prev_stream = new_stream
	play()
	pass


func _on_finished() -> void:
	stream = prev_stream
	play()
