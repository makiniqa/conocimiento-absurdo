extends Control

var change_level := false
var next_level := 1
var shouldQuit := false
var music = preload("uid://c83y38jq3nrp8")

func shouldChangeLevel() -> bool:
	return change_level

func getNextLevel() -> int:
	return next_level

func _on_start_button_pressed() -> void:
	$AnimationPlayer.play("FadeOut")

func _on_quit_button_button_up() -> void:
	shouldQuit = true
	$AnimationPlayer.play("FadeOut")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if shouldQuit:
		get_tree().quit()
	else:
		change_level = true
