extends Node

var levels = []
var current_level

signal level_changed
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

func change_level(level) -> void:
	if current_level == 0:
		menu_exit.emit()
	for children in get_children(true):
		remove_child(children)
		children.queue_free()
	if level == 0:
		menu_enter.emit()
	current_level = level
	add_child(load(levels[current_level]).instantiate())
	level_changed.emit()
	
func _process(_delta: float) -> void:
	for child in get_children(true):
		if child.shouldChangeLevel():
			change_level(child.getNextLevel())
