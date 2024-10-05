extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.equip_item.connect(on_equip_item)
	self.texture = preload("res://icon.svg")

func on_equip_item(new_texture) -> void:
	self.texture = new_texture
	
	
