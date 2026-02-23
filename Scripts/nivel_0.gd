extends Control

var change_level := false
var next_level: int

func shouldChangeLevel() -> bool:
	return change_level

func getNextLevel() -> int:
	return next_level

func _on_start_button_pressed() -> void:
	change_level = true
	next_level = 1
