extends Level

var tecnico := Character.new("Tecnico", "honk")
var music = null

func _ready():
	Character.dialogueBox = $DialogueBox
	$Player/Camera2D.enabled = false
	$"AnimationPlayer".play("Enter")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Enter":
		$DialogueBox.begin_dialogue("fin0")
		pibe.say("oh, que es esto? :O")
		dios.say("...")
		dios.say("CORTEZA.")
		dios.say("GAZA.")
		dios.say("LUPA")
		pibe.say("... que se supone que significa esto?")
		dios.say("...")
		dios.say("AFEITAR.")
		dios.say("ITALIANO.")
		dios.say("SOCIEDAD")
		pibe.say("no entiendo D:")
		$DialogueBox.set_callable_on_queue_end(func () : $AnimationPlayer.play("EnterITGuy"))
	elif anim_name == "EnterITGuy":
		$DialogueBox.begin_dialogue("fin1")
		tecnico.say("oh, acá está la maquina")
		tecnico.say("eh que haces vos? no podés estar acá")
		pibe.say("vine acá en busca de dios :O")
		pibe.say("pasa que lo escucho hablandome y me dijo que venga acá")
		pibe.say("pero ahora no le encuentro sentido a lo que me dice")
		tecnico.say("aahh ok, ya se que pasa")
		tecnico.say("acá no está dios pibe, este es el banco")
		tecnico.say("y esta es la maquina que genera los alias de las cuentas")
		tecnico.say("pero resulta que la maquina está medio medio")
		tecnico.say("viste como andan desfinanciando todo ahora?")
		tecnico.say("que hijos de puta...")
		tecnico.say("bueno, resulta que ahora la maquina está transmitiendo los aliases que genera en una frecuencia de radio")
		tecnico.say("y esa frecuencia es captada por algunos chips cerebrales que implantó elon musk en la población")
		tecnico.say("me mandaron a mi a arreglar eso")
		$DialogueBox.set_callable_on_queue_end(func () : $AnimationPlayer.play("ArreglaPC"))
	elif anim_name == "ArreglaPC":
		$DialogueBox.begin_dialogue("fin2")
		tecnico.say("...")
		tecnico.say("*tikitakatikitaka*")
		tecnico.say("listo")
		tecnico.say("ahí debería estar")
		tecnico.say("ya no vas a escuchar más a dios pibe :)")
		pibe.say("D:")
		pibe.say("p-p-pero...")
		pibe.say("no puede ser...")
		pibe.say("realmente es así?")
		pibe.say("...dios no existe?")
		tecnico.say("exacto :)")
		pibe.say("pero que voy a hacer ahora con mi vida? D:")
		tecnico.say("yyy, mientras no malgastes tu vida estudiando computación como yo (ahre)")
		pibe.say("pero no...")
		pibe.say("no puede ser :(")
		pibe.say("Dios, tenés que estar ahí... decí algo por favor...")
		$DialogueBox.set_callable_on_queue_end(func () : $AnimationPlayer.play("FadeOut"))
	elif anim_name == "FadeOut":
		$DialogueBox.begin_dialogue("fin4")
		pibe.say("...")
		pibe.say("...")
		pibe.say("...")
		pibe.say("...")
		pibe.say("...")
		dios.say("...")
		$DialogueBox.set_callable_on_queue_end(end_level)
	$DialogueBox.end_dialogue()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "FadeOut":
		$DialogueBox.begin_dialogue("fin3")
		pibe.say("Por favor...")
		pibe.say("...")
	$DialogueBox.end_dialogue()

func end_level():
	change_level = true
	next_level = 4 
