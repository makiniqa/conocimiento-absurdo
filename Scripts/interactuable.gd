extends Sprite2D

var isInside := false

signal interact

func _input(event: InputEvent) -> void:
	if isInside and event is InputEventKey:
		if event.is_pressed() and event.keycode in [KEY_Z, KEY_SPACE, KEY_ENTER]:
			interact.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	isInside = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	isInside = false;
