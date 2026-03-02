extends Level


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
		$DialogueBox.queue_display_text("*salis por la puerta uwu*", DialogueBox.default_talking_speed)
		$AnimationPlayer.play("fade_out")
		$Player.active = false
		

func _process(_delta: float) -> void:
	if door_entered and not $AnimationPlayer.is_playing():
		change_level = true
		next_level = 2

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		$DialogueBox.queue_display_text("holiii, estoy en busqueda de dios OwO", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("el mismo me dijo que vive acá owo pero no se que onda", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("es re raro este lugar...", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("Oh esperá...", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("me está intentando hablando ahora mismo! :DDD", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("...", DialogueBox.default_talking_speed*0.25, "silence")
		$DialogueBox.queue_display_text("CIGARRILLO.", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.queue_display_text("ENGAÑO.", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.queue_display_text("MARCADOR.", DialogueBox.default_talking_speed*0.5, "god")
		$DialogueBox.queue_display_text("...", DialogueBox.default_talking_speed*0.5, "silence")
		$DialogueBox.queue_display_text("me pregunto que significará esto :O", DialogueBox.default_talking_speed)


func _on_dialogue_box_end_queue() -> void:
	$Player.active = true

func _on_interactuable_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("Que haces pibe, tenés un cigarro para convidar?", DialogueBox.default_talking_speed, "ah")  
		$DialogueBox.queue_display_text("disculpa no fumo", DialogueBox.default_talking_speed)
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("che el de la librería quiere que te vayas", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("decile a ese gil que si me convida un pucho me voy", DialogueBox.default_talking_speed, "ah")  
		$DialogueBox.queue_display_text("weno", DialogueBox.default_talking_speed)
		hablaste_con_orcnella = true
	elif not personita_tiene_hojita or not personita_tiene_marcadores:
		$DialogueBox.queue_display_text("si no tenes un cigarrillo tocá de acá pibe", DialogueBox.default_talking_speed, "ah")
	else:
		$DialogueBox.queue_display_text("holi acá tengo un cigarrillo", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("eeh gracias", DialogueBox.default_talking_speed, "ah")
		$DialogueBox.set_callable_on_queue_end(
			func (): $AnimationPlayer.play("la bruja se va")
		)
		$AnimatedGate.active = true
func _on_hojita_interact() -> void:
	$Player.active = false
	$hojita.queue_free()
	personita_tiene_hojita = true
	$DialogueBox.queue_display_text("omg una hojita hii", DialogueBox.default_talking_speed, "default", false, true)

func _on_libreria_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		$DialogueBox.queue_display_text("hola cómo va, somos una librería", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no tenemos muchos clientes por acá", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("la vieja esa los espanta a todes u.u", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("buee pero no seas malo con ella :(", default_talking_speed)
		$DialogueBox.queue_display_text("como sea, cuchame", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("te doy lo que quieras si lográs que esa wacha se vaya", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("weno owo", default_talking_speed)
		hablaste_con_libreria = true
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("dale wachín, hace que se vaya", default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("dice la señora que si le das un cigarrillo se va", default_talking_speed)
		$DialogueBox.queue_display_text("dios qué vieja conchuda", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mirá", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", default_talking_speed, "honk")
		$DialogueBox.queue_display_text("está lo suficientemente pasada de vino como para no darse cuenta", default_talking_speed, "honk")
		personita_tiene_marcadores = true


func _on_vuvuzela_interact() -> void:
	$Player.active = false
	$Vuvuzela.queue_free()
	$DialogueBox.queue_display_text("*hacés un montón de ruido*", default_talking_speed, "honk")
	$DialogueBox.queue_display_text("pero la vieja no se inmuta", default_talking_speed, "honk")


func _on_manzana_interact() -> void:
	$Player.active = false
	$Manzana.queue_free()
	$DialogueBox.queue_display_text("*le tirás una manzana en la cabeza a la vieja*", default_talking_speed, "honk")
	$DialogueBox.queue_display_text("bueno tus modales no son los mejores pibe", default_talking_speed, "honk")
	$DialogueBox.queue_display_text("pero gracias tenía hambre", default_talking_speed, "honk")
