extends Level

func _ready():
	$Player/Camera2D.enabled = false
	$AnimationPlayer.play("enter_level")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		pass		
	$DialogueBox.queue_display_text("AUTO.", DialogueBox.default_talking_speed, "god")
	$DialogueBox.queue_display_text("PERRO.", DialogueBox.default_talking_speed, "god")
	$DialogueBox.queue_display_text("DISCO", DialogueBox.default_talking_speed, "god")
