extends Control
class_name  DialogueBox

var voices = {
	"silence": null,
	"default": preload("uid://w0c0yf3det61"),
	"honk": preload("uid://cqr12speeb8oe"),
	"ah": preload("uid://bic3xk4k7hl38"),
	"god": preload("uid://wl0yevjkglay")
}

const default_talking_speed := 15.0

class DialogueComponent:
	var text: String = ""
	var speed: float = 0.0 # in characters per second
	var voice: String = "default"
	
	func _init(text: String, speed: float, voice: String = "default"):
		self.text = text
		self.speed = speed
		self.voice = voice

var waitTime: float = 1.5
var t0: float = 0
var t1: float = 0
var displayTime: float = 0
var displayTextQueue: Array[DialogueComponent] = []
var displayText: String = ""
var currentText: String = ""
var textIndex := 0
var shouldDisplay := false
var charsPerSecond := 0.0
var callableOnQueueEnd : Callable = func (): pass

#signal newCharInText
signal endQueue

func set_callable_on_queue_end(fun: Callable):
	callableOnQueueEnd = fun

func _ready():
	$CanvasLayer.visible = false
	
func queue_display_text(text:String, speed: float, voice: String = "default", allow_repeat: bool = false, cancel_all_before: bool = false):
	var dialogueComponent = DialogueComponent.new(text,speed,voice)
	if allow_repeat or (dialogueComponent not in displayTextQueue and dialogueComponent.text != displayText):
		if cancel_all_before:
			shouldDisplay = false
			displayTextQueue.clear()
		displayTextQueue.append(dialogueComponent)

func _process(_delta: float) -> void:
	if not shouldDisplay:
		var next = displayTextQueue.pop_front()
		if next == null:
			return
		var text = next.text
		var speed = next.speed
		var voice = next.voice
		if not text.is_empty() and speed > 0.0:
			shouldDisplay = true
			displayTime = text.length() / speed + waitTime
			displayText = text
			currentText = ""
			textIndex = 0
			charsPerSecond = speed
			t0 = Time.get_ticks_msec()*1.0e-3
			$CanvasLayer.visible = true
			$CanvasLayer/Label.text = currentText
			if voice in voices.keys():
				$AudioStreamPlayer.stream = voices[voice]
			else:
				$AudioStreamPlayer.stream = voices["default"]
	if shouldDisplay:
		t1 = Time.get_ticks_msec()*1.0e-3
		var delta = t1-t0
		var pressed_cancel = Input.is_action_just_pressed("cancel")
		if pressed_cancel:
			textIndex = displayText.length()
			delta = displayTime+0.1
		elif delta >= textIndex/charsPerSecond and currentText != displayText:
			textIndex += 1
			currentText = displayText.substr(0,textIndex)
			$CanvasLayer/Label.text = currentText
			if $AudioStreamPlayer.stream:
				$AudioStreamPlayer.play()
			#newCharInText.emit()
		if (delta > displayTime):
			shouldDisplay = false
			displayText = ""
			$CanvasLayer.visible = false
			if displayTextQueue.is_empty():
				endQueue.emit()
				callableOnQueueEnd.call()
				callableOnQueueEnd = func (): pass
