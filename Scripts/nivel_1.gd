extends Level

var door_entered := false
var time_door_entered: int

func _on_animated_gate_entered(where: Door) -> void:
	if not door_entered:
		door_entered = true
		$DialogueBox.display_text("*salis por la puerta uwu*", 2.0)
		time_door_entered = Time.get_ticks_msec()


func _process(_delta: float) -> void:
	if door_entered and Time.get_ticks_msec() - time_door_entered >= 2000:
		change_level = true
		next_level = 0
