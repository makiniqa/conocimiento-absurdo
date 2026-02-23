extends Level

func _on_door_entered(where: Door) -> void:
	print("Salisteee :3333")
	change_level = true
	next_level = 0
	#get_tree().quit()
