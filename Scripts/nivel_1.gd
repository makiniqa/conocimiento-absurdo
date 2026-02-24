extends Level

var door_entered := false
var time_door_entered: int
var hablaste_con_libreria := false
var hablaste_con_orcnella := false
var personita_tiene_hojita := false
var personita_tiene_marcadores := false

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
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("Que haces pibe, tenés un cigarro para convidar?", 5.0, "ah")  
		$DialogueBox.queue_display_text("disculpa no fumo", 2.0)
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("che el de la librería quiere que te vayas", 5.0)
		$DialogueBox.queue_display_text("decile a ese gil que si me convida un pucho me voy", 5.0, "ah")  
		$DialogueBox.queue_display_text("weno", 1.0)
		hablaste_con_orcnella = true
	elif not personita_tiene_hojita or not personita_tiene_marcadores:
		$DialogueBox.queue_display_text("si no tenes un cigarrillo tocá de acá pibe", 5.0)
	else:
		$DialogueBox.queue_display_text("holi acá tengo un cigarrillo", 5.0)
		$DialogueBox.queue_display_text("eeh gracias", 1.0)
		$DialogueBox.set_callable_on_queue_end(
			func (): $AnimationPlayer.play("la bruja se va")
		)
		$AnimatedGate.active = true
func _on_hojita_interact() -> void:
	$Player.active = false
	$hojita.queue_free()
	personita_tiene_hojita = true
	$DialogueBox.queue_display_text("omg una hojita hii", 5.0, "default", false, true)

func _on_libreria_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("hola como va, somos una libreria", 5.0, "honk")
		$DialogueBox.queue_display_text("no tenemos muchos clientes por aca", 5.0, "honk")
		$DialogueBox.queue_display_text("la vieja esa los espanta todoactives u.u", 5.0, "honk")
		$DialogueBox.queue_display_text("buee pero no seas malo con ella :(", 5.0)
		$DialogueBox.queue_display_text("como sea, cuchame", 1.0, "honk")
		$DialogueBox.queue_display_text("te doy lo que quieras si logras que esa wacha se vaya", 5.0, "honk")
		$DialogueBox.queue_display_text("weno owo", 1.0)
		hablaste_con_libreria = true
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("dale wachin, hace que se vaya", 5.0, "honk")
	else:
		$DialogueBox.queue_display_text("dice la señora que si le das un cigarrillo se va", 5.0)
		$DialogueBox.queue_display_text("dios que vieja conchuda", 5.0, "honk")
		$DialogueBox.queue_display_text("mira", 1.0, "honk")
		$DialogueBox.queue_display_text("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", 5.0, "honk")
		$DialogueBox.queue_display_text("está lo suficientemente pasada de vino como para no darse cuenta", 5.0, "honk")
		personita_tiene_marcadores = true
