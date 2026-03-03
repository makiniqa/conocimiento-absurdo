extends Level

var door_entered := false
var hablaste_con_libreria := false
var hablaste_con_orcnella := false
var personita_tiene_hojita := false
var personita_tiene_marcadores := false
var puerta_desbloqueada := false

class Character:
	static var dialogueBox
	var name: String = ""
	var voice: String = "default"
	var speed: float = 0.0
	
	func _init(name, voice = "default", speed := DialogueBox.default_talking_speed):
		self.name = name
		self.voice = voice
		self.speed = speed
	
	func say(text: String, dialogueID: String = ""):
		dialogueBox.queue_display_text(text, DialogueBox.default_talking_speed, self.voice, dialogueID)
		
		
var pibe := Character.new("Pibe")
var orcnella := Character.new("Orcnella", "ah")
var librero := Character.new("Librero", "honk")
var dios := Character.new("Librero", "god", DialogueBox.default_talking_speed*0.5)

func _ready():
	Character.dialogueBox = $DialogueBox
	$AnimationPlayer.play("enter_level")

func _on_animated_gate_entered(where: Door) -> void:
	if not door_entered:
		door_entered = true
		pibe.say("*salis por la puerta uwu*")
		$AnimationPlayer.play("fade_out")
		$Player.active = false
		

func _process(_delta: float) -> void:
	if door_entered and not $AnimationPlayer.is_playing():
		change_level = true
		next_level = 2

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		pibe.say("holiii, estoy en busqueda de dios >:)")
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


func _on_dialogue_box_end_queue() -> void:
	$Player.active = true

func _on_interactuable_interact() -> void:
	$Player.active = false
	if not hablaste_con_libreria:
		orcnella.say("Que haces pibe, tenés un cigarro para convidar?")
		pibe.say("disculpa no fumo")
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
func _on_hojita_interact() -> void:
	$Player.active = false
	if personita_tiene_marcadores:
		$hojita.queue_free()
		personita_tiene_hojita = true
		pibe.say("omg una hojita hii")
	else:
		pibe.say("hay una hoja en el piso")
		pibe.say("pero no tenés nada para escribir")

func _on_libreria_interact() -> void:
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
		librero.say("dale wachín, hace que se vaya", dialogueID)
	else:
		var dialogueID := "libreria2"
		pibe.say("dice la señora que si le das un cigarrillo se va", dialogueID)
		librero.say("dios qué vieja conchuda", dialogueID)
		librero.say("mirá", dialogueID)
		librero.say("yo no fumo pero agarrate estos marcadores y hacele un \"cigarrillo\" a la señora", dialogueID)
		librero.say("está lo suficientemente pasada de vino como para no darse cuenta", dialogueID)
		personita_tiene_marcadores = true


func _on_vuvuzela_interact() -> void:
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Vuvuzela.queue_free()
		pibe.say("*hacés un montón de ruido*", "vuvuzela0")
		pibe.say("pero la vieja no se inmuta", "vuvuzela0")
	else:
		pibe.say("una vuvuzela", "vuvuzela1")
		pibe.say("cómo odiás estas vergas", "vuvuzela1")

func _on_manzana_interact() -> void:
	$Player.active = false
	if hablaste_con_orcnella and not puerta_desbloqueada:
		$Manzana.queue_free()
		pibe.say("*le tirás una manzana en la cabeza a la vieja*")
		orcnella.say("bueno tus modales no son los mejores pibe", "honk")
		orcnella.say("pero gracias tenía hambre", "honk")
	else:
		pibe.say("una suculenta manzana")
		pibe.say("no tenés hambre.")

func _on_moneda_interact() -> void:
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

func _on_gatito_interact() -> void:
	$Player.active = false
	$DialogueBox.queue_display_text("miaaaauuuuuu", DialogueBox.default_talking_speed, "honk")
	$DialogueBox.queue_display_text("digo guau", DialogueBox.default_talking_speed, "honk")


func _on_kiosko_interact() -> void:
	$Player.active = false
	if hablaste_con_libreria and not puerta_desbloqueada:
		$DialogueBox.queue_display_text("capo no tendrás un paquete de cigarrillos?", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("no máster recién se me acabaron", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("pero tengo para cargarte la SUBE", DialogueBox.default_talking_speed, "honk")
	else:
		$DialogueBox.queue_display_text("hoy hay 5x1 en guaymallén de fruta", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("mm otro día rey", DialogueBox.default_talking_speed, "honk")
		$DialogueBox.queue_display_text("vos te la perdés", DialogueBox.default_talking_speed, "honk")
	
