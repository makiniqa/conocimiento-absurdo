extends Node

var levels = []
var current_level

signal menu_enter
signal menu_exit

func _ready() -> void:
	var levelRe := RegEx.create_from_string("nivel_[0-9]+\\.tscn")
	var dir := DirAccess.open("res://Scenes")
	for file: String in dir.get_files():
		if levelRe.search(file):
			levels.append("res://Scenes/" + file)
	
	current_level = 0
	add_child(load(levels[0]).instantiate())
	menu_enter.emit()

func _on_level_change(level) -> void:
	if current_level == 0:
		menu_exit.emit()
