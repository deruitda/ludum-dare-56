extends Control


@onready var buttons_v_box = $ButtonsVbox
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	SignalBus.go_to_main_menu.connect(show)
	focus_button()

func _on_start_game_button_pressed() -> void:
	SignalBus.start_game.emit()
	hide()

func _on_quit_button_pressed() -> void:
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


func _on_show_controls_pressed() -> void:
	texture_rect.visible = !texture_rect.visible
