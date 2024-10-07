extends Control

@onready var heart_1: HeartSprite = $Container/Heart1
@onready var heart_2: HeartSprite = $Container/Heart2
@onready var heart_3: HeartSprite = $Container/Heart3

func set_current_health(new_health: int) -> void:
	# Ensure new_health is clamped between 0 and 3, assuming 3 hearts max
	new_health = clamp(new_health, 0, 3)
	
	# Update hearts based on new_health
	heart_1.set_is_heart_full(new_health >= 1)
	heart_2.set_is_heart_full(new_health >= 2)
	heart_3.set_is_heart_full(new_health >= 3)
