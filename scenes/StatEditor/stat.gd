extends HBoxContainer

@export var attribute_name = "value"
@export var label_text: String = "Label"

@onready var label: Label = $Label
@onready var value: Label = $Value
@onready var h_slider: HSlider = $VBoxContainer/HSlider

@onready var initial_value_is_set: Boolean = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = label_text + ": "
	StatEditorBus.set_initial_label_value(set_initial_label_value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_value(new_value) -> void:
	value.text = str(new_value)

func set_initial_label_value(incoming_attribute_name: String, attribute_value):
	
	if !initial_value_is_set and attribute_name == incoming_attribute_name:
		

func _on_h_slider_changed() -> void:
	StatEditorBus.input_changed.emit(attribute_name, h_slider.value)
	pass # Replace with function body.
