extends Level

const default_talking_speed := 15.0

var door_entered := false
var hablaste_con_libreria := false
var hablaste_con_orcnella := false
var personita_tiene_hojita := false
var personita_tiene_marcadores := false

func _ready():
	$AnimationPlayer.play("enter_level")

func _on_animated_gate_entered(where: Door) -> void:
	if not door_entered:
		door_entered = true
		$DialogueBox.queue_display_text("*salis por la puerta uwu*", default_talking_speed)
		$AnimationPlayer.play("fade_out")
		$Player.active = false
		

func _process(_delta: float) -> void:
	if door_entered and not $AnimationPlayer.is_playing():
		change_level = true
		next_level = 0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		$DialogueBox.queue_display_text("holiii, estoy en busqueda de dios OwO", default_talking_speed)
		$DialogueBox.queue_display_text("me dijeron que vive acá owo pero no se que onda", default_talking_speed)
		$DialogueBox.queue_display_text("es re raro este lugar...", default_talking_speed)


func _on_dialogue_box_end_queue() -> void:
	$Player.active = true

func _on_interactuable_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("Que haces pibe, tenés un cigarro para convidar?", default_talking_speed, "ah")  
		$DialogueBox.queue_display_text("disculpa no fumo", default_talking_speed)
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("che el de la librería quiere que te vayas", default_talking_speed)
		$DialogueBox.queue_display_text("decile a ese gil que si me convida un pucho me voy", default_talking_speed, "ah")  
		$DialogueBox.queue_display_text("weno", default_talking_speed)
		hablaste_con_orcnella = true
	elif not personita_tiene_hojita or not personita_tiene_marcadores:
		$DialogueBox.queue_display_text("si no tenes un cigarrillo tocá de acá pibe", default_talking_speed, "ah")
	else:
		$DialogueBox.queue_display_text("holi acá tengo un cigarrillo", default_talking_speed)
		$DialogueBox.queue_display_text("eeh gracias", default_talking_speed, "ah")
		$DialogueBox.set_callable_on_queue_end(
			func (): $AnimationPlayer.play("la bruja se va")
		)
		$AnimatedGate.active = true
func _on_hojita_interact() -> void:
	$Player.active = false
	$hojita.queue_free()
	personita_tiene_hojita = true
	$DialogueBox.queue_display_text("omg una hojita hii", default_talking_speed, "default", false, true)

func _on_libreria_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("hola como va, somos una libreria", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no tenemos muchos clientes por aca", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("la vieja esa los espanta a todes u.u", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("buee pero no seas malo con ella :(", default_talking_speed)
		$DialogueBox.queue_display_text("como sea, cuchame", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("te doy lo que quieras si logras que esa wacha se vaya", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("weno owo", default_talking_speed)
		hablaste_con_libreria = true
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("dale wachin, hace que se vaya", default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("dice la señora que si le das un cigarrillo se va", default_talking_speed)
		$DialogueBox.queue_display_text("dios que vieja conchuda", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mira", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("está lo suficientemente pasada de vino como para no darse cuenta", default_talking_speed, "honk")
		personita_tiene_marcadores = true
