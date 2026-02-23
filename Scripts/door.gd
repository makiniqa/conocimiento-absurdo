extends Sprite2D
class_name Door

## si la puerta se puede abrir
@export
var active: bool
## si la puerta está abierta
@export
var isOpen: bool


func _init() -> void:
	pass

func _on_interact() -> void:
	if not active:
		pass
	pass
