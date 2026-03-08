extends Level

var door_entered := false
var hablaste_con_libreria := false
var hablaste_con_orcnella := false
var personita_tiene_hojita := false
var personita_tiene_marcadores := false
var puerta_desbloqueada := false
var music := preload("uid://xbanpo4nr1a3")

var orcnella := Character.new("Orcnella", "ah")
var librero := Character.new("Librero", "honk")
var kioskero := Character.new("Kioskero", "honk")
var perro := Character.new("Pishito", "bark")

func _ready():
	Character.dialogueBox = $DialogueBox
	$AnimationPlayer.play("enter_level")

func _on_animated_gate_entered(where: Door) -> void:
	if not door_entered:
		door_entered = true
		#pibe.say("*salis por la puerta uwu*")
		$AnimationPlayer.play("fade_out")
		$Player.active = false
		

func _process(_delta: float) -> void:
	if door_entered and not $AnimationPlayer.is_playing():
		change_level = true
		next_level = 2

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		if not $DialogueBox.begin_dialogue("enter_level"):
			return
		$Player.active = false
		pibe.say("holiii, estoy en búsqueda de dios >:)")
		pibe.say("él mismo me dijo que vive acá pero no sé qué onda")
		pibe.say("es re raro este lugar...")
		pibe.say("uh bancá...")
		pibe.say("me está intentando hablar ahora mismo! :DDD")
		dios.say("...")
		dios.say("CIGARRILLO.")
		dios.say("ENGAÑO.")
		dios.say("MARCADOR.")
		dios.say("...")
		pibe.say("me pregunto qué significará esto :O")
		$DialogueBox.set_callable_on_queue_end(func (): $Player.active = true)
		$DialogueBox.end_dialogue()


func _on_dialogue_box_end_queue() -> void:
	$Player.active = true

func _on_interactuable_interact() -> void:
	if not $DialogueBox.begin_dialogue("orcnella"):
		return
	$Player.active = false
	if not hablaste_con_libreria:
		orcnella.say("qué hacés pibe, tenés un cigarro para convidar?")
		pibe.say("disculpá no fumo")
	elif not hablaste_con_orcnella:
		pibe.say("che el de la librería quiere que te vayas")
		orcnella.say("decile a ese gil que si me convida un pucho me voy")
		pibe.say("weno")
		hablaste_con_orcnella = true
	elif not personita_tiene_hojita or not personita_tiene_marcadores:
		orcnella.say("si no tenes un cigarrillo tocá de acá pibe")
	else:
		pibe.say("holi acá tengo un cigarrillo")
		orcnella.say("eeh gracias")
		$DialogueBox.set_callable_on_queue_end(
			func (): $AnimationPlayer.play("la bruja se va")
		)
		puerta_desbloqueada = true
		$AnimatedGate.active = true
	$DialogueBox.end_dialogue()
	
func _on_hojita_interact() -> void:
	if not $DialogueBox.begin_dialogue("hojita"):
		return
	$Player.active = false
	if personita_tiene_marcadores:
		$hojita.queue_free()
		personita_tiene_hojita = true
		pibe.say("omg una hojita hii")
	else:
		pibe.say("hay una hoja en el piso")
		pibe.say("pero no tenés nada para escribir")
	$DialogueBox.end_dialogue()

func _on_libreria_interact() -> void:
	if not $DialogueBox.begin_dialogue("libreria"):
		return
	$Player.active = false
	if puerta_desbloqueada:
		librero.say("te debo la vida pibe")
	elif not hablaste_con_libreria:
		librero.say("hola cómo va, somos una librería")
		librero.say("no tenemos muchos clientes por acá")
		librero.say("la vieja ésa los espanta a todes u.u")
		pibe.say("buee pero no seas malo con ella :(")
		librero.say("como sea, cuchame")
		librero.say("te doy lo que quieras si lográs que esa wacha se vaya")
		pibe.say("weno owo")
		hablaste_con_libreria = true
	elif not hablaste_con_orcnella:
		var dialogueID := "libreria1"
		librero.say("dale wachín, hacé que se vaya", dialogueID)
	else:
		var dialogueID := "libreria2"
		pibe.say("dice la señora que si le das un cigarrillo se va", dialogueID)
		librero.say("dios qué vieja conchuda", dialogueID)
		librero.say("mirá", dialogueID)
		librero.say("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", dialogueID)
		librero.say("está lo suficientemente pasada de vino como para no darse cuenta", dialogueID)
		personita_tiene_marcadores = true
	$DialogueBox.end_dialogue()


func _on_vuvuzela_interact() -> void:
	if not $DialogueBox.begin_dialogue("vuvuzela"):
		return
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Vuvuzela.queue_free()
		pibe.say("*hacés un montón de ruido*")
		pibe.say("pero la vieja no se inmuta")
	else:
		pibe.say("una vuvuzela")
		pibe.say("cómo odiás estas vergas")
	$DialogueBox.end_dialogue()

func _on_manzana_interact() -> void:
	if not $DialogueBox.begin_dialogue("manzana"):
		return
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Manzana.queue_free()
		pibe.say("*le tirás una manzana en la cabeza a la vieja*")
		orcnella.say("bueno tus modales no son los mejores pibe")
		orcnella.say("pero gracias tenía hambre")
	else:
		pibe.say("una suculenta manzana")
		pibe.say("no tenés hambre")
	$DialogueBox.end_dialogue()

func _on_moneda_interact() -> void:
	if not $DialogueBox.begin_dialogue("moneda"):
		return
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Moneda.queue_free()
		pibe.say("*tirás la moneda del otro lado de la cerca*")
		pibe.say("che vieja")
		pibe.say("mirá hay plata por allá")
		orcnella.say("no creo en el dinero pibe")
		orcnella.say("ni en los microondas")
	else:
		pibe.say("uia, platita")
	$DialogueBox.end_dialogue()

func _on_gatito_interact() -> void:
	if not $DialogueBox.begin_dialogue("gatito"):
		return
	$Player.active = false
	$Gatito/AnimatedSprite2D.play("Bark")
	perro.say("miaaaauuuuuu")
	perro.say("digo guau")
	$DialogueBox.set_callable_on_queue_end(
		func () : $Gatito/AnimatedSprite2D.play("Idle")
	)
	$DialogueBox.end_dialogue()


func _on_kiosko_interact() -> void:
	if not $DialogueBox.begin_dialogue("kiosko"):
		return
	$Player.active = false
	if hablaste_con_libreria and not puerta_desbloqueada:
		pibe.say("capo no tendrás un paquete de cigarrillos?")
		kioskero.say("no máster recién se me acabaron")
		kioskero.say("pero tengo para cargarte la SUBE")
	else:
		kioskero.say("hoy hay 5x1 en guaymallén de fruta")
		pibe.say("mm otro día rey")
		kioskero.say("vos te la perdés")
	$DialogueBox.end_dialogue()
	
