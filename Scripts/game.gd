extends Node2D

func _on_level_loader_level_changed() -> void:
	print("cambio de nivel :3")
	pass # Replace with function body.


func _on_level_loader_music_changed(stream: Variant) -> void:
	if stream:
		$Music.stream = stream
		$Music.play()
	else:
		$Music.stop()
