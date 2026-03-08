extends Control

var music := preload("uid://b8r1fy67uav3q")

var change_level := false
var next_level := 0

func getNextLevel() -> int:
	return next_level

func shouldChangeLevel():
	return change_level

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	change_level = true
