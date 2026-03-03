extends Level

func _ready():
	$Player/Camera2D.enabled = false
	$AnimationPlayer.play("enter_level")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		$Player.active = false
		$DialogueBox.queue_display_text("...", DialogueBox.default_talking_speed*0.25, "silence")
		$DialogueBox.queue_display_text("AUTO.", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.queue_display_text("PERRO.", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.queue_display_text("DISCO", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.set_callable_on_queue_end(
			func () : $Player.active = true
			)
	elif anim_name == "atropellao":
		$Player.active = true
		$AutoRoto.visible = true
		$AnimationPlayer.play("aparecePerritoWaf")
		
var interaccionesCQB := 0
func _on_chica_que_baila_interact() -> void:
	if interaccionesCQB%3 == 0:
		$DialogueBox.queue_display_text("bailando bailando", DialogueBox.default_talking_speed*0.75, "ah")
	elif interaccionesCQB%3 == 1:
		$DialogueBox.queue_display_text("amigos adios... adios...", DialogueBox.default_talking_speed*0.75, "ah")
	else:
		$DialogueBox.queue_display_text("el silencio loco", DialogueBox.default_talking_speed*0.75, "ah")
	interaccionesCQB += 1


func _on_tocadiscos_interact() -> void:
	pass # Replace with function body.


func _on_cortina_y_cuadro_interact() -> void:
	$Player.active = false
	$AnimationPlayer.play("preatropellao")
	$DialogueBox.queue_display_text("che hay algo acá", DialogueBox.default_talking_speed, "ah")
	# acá se abre la cortina y aparece un cuadro
	$DialogueBox.queue_display_text("<<acá se abre la cortina y aparece un cuadro>>", DialogueBox.default_talking_speed*2, "silence")
	$DialogueBox.queue_display_text("omg un cuadro", DialogueBox.default_talking_speed, "ah")
	# el auto acelera
	$DialogueBox.queue_display_text("<<el auto acelera>>", DialogueBox.default_talking_speed*2, "silence")
	$DialogueBox.queue_display_text("AAAAAAAAAAAA", DialogueBox.default_talking_speed*2, "ah")
	$DialogueBox.set_callable_on_queue_end(
		func (): $AnimationPlayer.play("atropellao")
		)

func _on_pishito_interact() -> void:
	$DialogueBox.queue_display_text("PISHITO 😍", DialogueBox.default_talking_speed, "ah")
	$DialogueBox.queue_display_text("waf!", DialogueBox.default_talking_speed, "bark")

func _on_auto_roto_interact() -> void:
	$DialogueBox.queue_display_text(":O se salió el cosito este de la rueda", DialogueBox.default_talking_speed, "ah")
	$DialogueBox.queue_display_text("creo que este pishito quiere que se lo tire!", DialogueBox.default_talking_speed, "ah")
