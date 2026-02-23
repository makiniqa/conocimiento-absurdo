extends Node

var levels = []
var current_level

func _ready() -> void:
	var levelRe := RegEx.create_from_string("nivel_[0-9]+\\.tscn")
	var dir := DirAccess.open("res://Scenes")
	for file: String in dir.get_files():
		if levelRe.search(file):
			levels.append("res://Scenes/" + file)
	
	current_level = load(levels[0]).instantiate()
	add_child(current_level)
	


func _on_level_change(level) -> void:
	pass
