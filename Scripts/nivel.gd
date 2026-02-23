extends Node2D
class_name Level

var change_level := false
var next_level : int

func shouldChangeLevel() -> bool:
	return change_level

func getNextLevel() -> int:
	return next_level
