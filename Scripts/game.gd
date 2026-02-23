extends Node2D

func _ready():
	$Player/Camera2D.enabled = false


func _on_level_loader_menu_enter() -> void:
	$Player/Camera2D.enabled = false
	$Player.visible = false

func _on_level_loader_menu_exit() -> void:
	$Player/Camera2D.enabled = true
	$Player.visible = true

func _on_level_loader_level_changed() -> void:
	print("cambio de nivel :3")
	pass # Replace with function body.
