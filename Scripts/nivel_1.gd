extends Level


var door_entered := false
var hablaste_con_libreria := false
var hablaste_con_orcnella := false
var personita_tiene_hojita := false
var personita_tiene_marcadores := false
var puerta_desbloqueada := false

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
		puerta_desbloqueada = true
		$AnimatedGate.active = true
func _on_hojita_interact() -> void:
	$Player.active = false
	$hojita.queue_free()
	personita_tiene_hojita = true
	$DialogueBox.queue_display_text("omg una hojita hii", DialogueBox.default_talking_speed, "default", false, true)

func _on_libreria_interact() -> void:
	$Player.active = false
	if puerta_desbloqueada:
		$DialogueBox.queue_display_text("te debo la vida pibe", DialogueBox.default_talking_speed, "honk")
	elif not hablaste_con_libreria:
		$DialogueBox.queue_display_text("hola cómo va, somos una librería", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no tenemos muchos clientes por acá", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("la vieja esa los espanta a todes u.u", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("buee pero no seas malo con ella :(", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("como sea, cuchame", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("te doy lo que quieras si lográs que esa wacha se vaya", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("weno owo", DialogueBox.default_talking_speed)
		hablaste_con_libreria = true
	elif not hablaste_con_orcnella:
		$DialogueBox.queue_display_text("dale wachín, hace que se vaya", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("dice la señora que si le das un cigarrillo se va", DialogueBox.default_talking_speed)
		$DialogueBox.queue_display_text("dios qué vieja conchuda", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mirá", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("está lo suficientemente pasada de vino como para no darse cuenta", DialogueBox.default_talking_speed, "honk")
		personita_tiene_marcadores = true


func _on_vuvuzela_interact() -> void:
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Vuvuzela.queue_free()
		$DialogueBox.queue_display_text("*hacés un montón de ruido*", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("pero la vieja no se inmuta", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("una vuvuzela", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("cómo odiás estas vergas", DialogueBox.default_talking_speed, "honk")

func _on_manzana_interact() -> void:
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Manzana.queue_free()
		$DialogueBox.queue_display_text("*le tirás una manzana en la cabeza a la vieja*", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("bueno tus modales no son los mejores pibe", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("pero gracias tenía hambre", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("una suculenta manzana", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no tenés hambre.", DialogueBox.default_talking_speed, "honk")

func _on_moneda_interact() -> void:
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Moneda.queue_free()
		$DialogueBox.queue_display_text("*tirás la moneda del otro lado de la cerca*", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("che vieja", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mirá hay plata por allá", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no creo en el dinero pibe", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("ni en los microondas", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("uia, platita", DialogueBox.default_talking_speed, "honk")


func _on_gatito_interact() -> void:
	$Player.active = false
	$DialogueBox.queue_display_text("miaaaauuuuuu", DialogueBox.default_talking_speed, "honk")
	$DialogueBox.queue_display_text("digo guau", DialogueBox.default_talking_speed, "honk")


func _on_kiosko_interact() -> void:
	$Player.active = false
	if hablaste_con_libreria and not puerta_desbloqueada:
		$DialogueBox.queue_display_text("capo tendrás un paquete de cigarrillos?", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no máster recién se me acabaron", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("pero tengo para cargarte la SUBE", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("hoy hay 5x1 en guaymallén de fruta", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mm otro día rey", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("vos te la perdés", DialogueBox.default_talking_speed, "honk")
	
