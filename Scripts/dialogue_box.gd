extends Control

class TextString:
	var text: String = ""
	var time: float = 0.0
	
	func _init(text: String, time: float):
		self.text = text
		self.time = time

var t0: float = 0
var t1: float = 0
var displayTime: float = 0
var displayTextQueue: Array[TextString] = []
var displayText: String = ""
var currentText: String = ""
var textIndex := 0
var shouldDisplay := false
var charsPerSecond := 0.0

signal newCharInText

func _ready():
	$CanvasLayer.visible = false

func queue_display_text(text:String, time: float):
	displayTextQueue.append(TextString.new(text,time))

func _process(_delta: float) -> void:
	if not shouldDisplay:
		var next = displayTextQueue.pop_front()
		if next == null:
			return
		var text = next.text
		var time = next.time
		shouldDisplay = not text.is_empty() and time > 0.0
		displayTime = time
		displayText = text
		currentText = ""
		textIndex = 0
		charsPerSecond = text.length() / (time * 0.5)
		t0 = Time.get_ticks_msec()*1.0e-3
		$CanvasLayer.visible = true
		$CanvasLayer/Label.text = currentText
	if shouldDisplay:
		t1 = Time.get_ticks_msec()*1.0e-3
		var delta = t1-t0
		if delta >= textIndex/charsPerSecond and currentText != displayText:
			textIndex += 1
			currentText = displayText.substr(0,textIndex)
			$CanvasLayer/Label.text = currentText
			newCharInText.emit()
			$AudioStreamPlayer.play()
		if (delta > displayTime):
			shouldDisplay = false
			$CanvasLayer.visible = false
