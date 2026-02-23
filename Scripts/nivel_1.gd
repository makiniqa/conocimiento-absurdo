extends Node2D


func _on_door_entered(where: Door) -> void:
	print("Salisteee :3333")
	get_tree().quit()
