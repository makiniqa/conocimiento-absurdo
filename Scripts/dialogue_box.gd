extends Control
class_name  DialogueBox

var voices = {
	"silence": null,
	"default": preload("uid://w0c0yf3det61"),
	"honk": preload("uid://cqr12speeb8oe"),
	"ah": preload("uid://bic3xk4k7hl38"),
	"god": preload("uid://wl0yevjkglay"),
	"bark": preload("uid://ieaeafhgb0uu")
}

const default_talking_speed := 15.0

class DialogueEvent:
	enum EventType {
		DIALOGUE_BEGIN,
		DIALOGUE_END,
		DIALOGUE_SPEECH,
		DIALOGUE_CALLABLE
	};
	var type: EventType
	var text: String = ""
	var speed: float = 0.0 # in characters per second
	var voice: String = "default"
	var dialogueID: String = "none"
	var name: String = ""
	
	func _init(type: EventType, text: String, speed: float, voice: String = "default", dialogueID: String = "none", name: String = ""):
		self.text = text
		self.speed = speed
		self.voice = voice
		self.dialogueID = dialogueID
		self.type = type
		self.name = name

var waitTime: float = 1.5
var t0: float = 0
var t1: float = 0
var displayTime: float = 0
var displayTextQueue: Array[DialogueEvent] = []
var displayText: String = ""
var currentText: String = ""
var currentName: String = ""
var currentDialogueID: String = ""
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

func begin_dialogue(dialogueID: String) -> bool:
	if (currentDialogueID == dialogueID):
		return false
	var event = DialogueEvent.new(DialogueEvent.EventType.DIALOGUE_BEGIN, "", 0.0, "", dialogueID)
	if event not in displayTextQueue:
		displayTextQueue.append(event)
	return true

func end_dialogue():
	var event = DialogueEvent.new(DialogueEvent.EventType.DIALOGUE_END, "", 0.0, "", currentDialogueID)
	if event not in displayTextQueue:
		displayTextQueue.append(event)

func queue_display_text(text:String, speed: float, voice: String = "default", dialogueID: String = "none", allow_repeat: bool = false, cancel_all_before: bool = false, name: String = ""):
	var event = DialogueEvent.new(DialogueEvent.EventType.DIALOGUE_SPEECH, text,speed,voice,dialogueID, name)
	if cancel_all_before:
		shouldDisplay = false
		displayTextQueue.clear()
	displayTextQueue.append(event)

func dequeue_event():
	var next = displayTextQueue.pop_front()
	if next == null:
		return
	match next.type:
		DialogueEvent.EventType.DIALOGUE_END:
			currentDialogueID = ""
		DialogueEvent.EventType.DIALOGUE_BEGIN:
			currentDialogueID = next.dialogueID
		DialogueEvent.EventType.DIALOGUE_CALLABLE:
			pass
		DialogueEvent.EventType.DIALOGUE_SPEECH:
			var text = next.text
			var speed = next.speed
			var voice = next.voice
			if not text.is_empty() and speed > 0.0:
				shouldDisplay = true
				displayTime = text.length() / speed + waitTime
				displayText = text
				currentText = ""
				currentName = next.name
				textIndex = 0
				charsPerSecond = speed
				t0 = Time.get_ticks_msec()*1.0e-3
				$CanvasLayer.visible = true
				$CanvasLayer/TextureRect/Label.text = currentText
				$CanvasLayer/TextureRect/Name.text = currentName
				if voice in voices.keys():
					$AudioStreamPlayer.stream = voices[voice]
				else:
					$AudioStreamPlayer.stream = voices["default"]

func show_textBox():
	t1 = Time.get_ticks_msec()*1.0e-3
	var delta = t1-t0
	var pressed_cancel = Input.is_action_just_pressed("cancel")
	if pressed_cancel:
		textIndex = displayText.length()
		delta = displayTime+0.1
	elif delta >= textIndex/charsPerSecond and currentText != displayText:
		textIndex += 1
		currentText = displayText.substr(0,textIndex)
		$CanvasLayer/TextureRect/Label.text = currentText
		if $AudioStreamPlayer.stream:
			$AudioStreamPlayer.play()
	if (delta > displayTime):
		shouldDisplay = false
		displayText = ""
		currentName = ""
		$CanvasLayer.visible = false


func _process(_delta: float) -> void:
	if not shouldDisplay:
		dequeue_event()
	if shouldDisplay:
		show_textBox()
	if displayTextQueue.is_empty():
		endQueue.emit()
		callableOnQueueEnd.call()
		callableOnQueueEnd = func (): pass
