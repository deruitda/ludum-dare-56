extends Control

@onready var death_label: Label = $Container/death_label
@onready var kills_label: Label = $Container/kills_label
@onready var total_time_label: Label = $Container/total_time_label


@onready var buttons_v_box = $ButtonsVbox

func _ready() -> void:
	death_label.text = "Number of Deaths: " + str(GameState.player_deaths)
	kills_label.text = "Number of Kills: " + str(GameState.enemies_killed)
	total_time_label.text = "Total Times: " + str(GameState.time_elapsed)
	focus_button()

func _on_retry_button_pressed() -> void:
	SignalBus.go_to_main_menu.emit()
	hide()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()

func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
