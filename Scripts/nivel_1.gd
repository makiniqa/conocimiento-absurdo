extends Level

var door_entered := false
var time_door_entered: int

func _ready():
	$AnimationPlayer.play("enter_level")

func _on_animated_gate_entered(where: Door) -> void:
	if not door_entered:
		door_entered = true
		$DialogueBox.queue_display_text("*salis por la puerta uwu*", 3.0)
		$AnimationPlayer.play("fade_out")
		$Player.active = false
		time_door_entered = Time.get_ticks_msec()
		

func _process(_delta: float) -> void:
	if door_entered and not $AnimationPlayer.is_playing():
		change_level = true
		next_level = 0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		$DialogueBox.queue_display_text("holiii, estoy en busqueda de dios OwO", 5.0)
		$DialogueBox.queue_display_text("me dijeron que vive acá owo pero no se que onda", 5.0)
		$DialogueBox.queue_display_text("es re raro este lugar...", 5.0)


func _on_dialogue_box_end_queue() -> void:
	$Player.active = true

func _on_interactuable_interact() -> void:
	$DialogueBox.queue_display_text("Que haces pibe, tenés un cigarro para convidar?", 5.0, "ah")  
