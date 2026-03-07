extends Node2D
class_name Level

class Character:
	static var dialogueBox
	var name: String = ""
	var voice: String = "default"
	var speed: float = 0.0
	
	func _init(name, voice = "default", speed := DialogueBox.default_talking_speed):
		self.name = name
		self.voice = voice
		self.speed = speed
	
	func say(text: String, dialogueID: String = ""):
		if dialogueBox:
			dialogueBox.queue_display_text(text, DialogueBox.default_talking_speed, self.voice, dialogueID)
		

var pibe := Character.new("Pibe")
var dios := Character.new("Dios", "god", DialogueBox.default_talking_speed*0.5)

var change_level := false
var next_level : int

func shouldChangeLevel() -> bool:
	return change_level

func getNextLevel() -> int:
	return next_level
