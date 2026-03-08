extends Level

var chica := Character.new("Chica", "ah", DialogueBox.default_talking_speed*0.75)
var perro := Character.new("Pishito", "bark")

var agarrasteLaChapa := false
var vinoElPerritoConELDisco := false
var agarrasteElDisco := false

func _ready():
	$Puerta/Salida/CollisionShape2D.disabled = true
	Character.dialogueBox = $DialogueBox
	$Player/Camera2D.enabled = false
	$AnimationPlayer.play("enter_level")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_level":
		$Player.active = false
		dios.say("...")
		dios.say("AUTO.")
		dios.say("PERRO.")
		dios.say("DISCO")
		$DialogueBox.set_callable_on_queue_end(
			func () : $Player.active = true
			)
	elif anim_name == "atropellao":
		$Player.active = true
		$AutoRoto.visible = true
		$AnimationPlayer.play("aparecePerritoWaf")
	elif anim_name == "chicaSeVa":
		$Puerta/Puerta1.play("open")
		$Puerta/Puerta2.play("open")
		$Puerta/StaticBody2D/CollisionShape2D.disabled = true
		$Puerta/Salida/CollisionShape2D.disabled = false
		
var interaccionesCQB := 0
func _on_chica_que_baila_interact() -> void:
	if interaccionesCQB%3 == 0:
		chica.say("bailando bailando")
	elif interaccionesCQB%3 == 1:
		chica.say("amigos adios... adios...")
	else:
		chica.say("el silencio loco")
	interaccionesCQB += 1


func _on_tocadiscos_interact() -> void:
	if not agarrasteElDisco:
		pibe.say("oh un tocadiscos :O que retro")
	else:
		$Tocadiscos/AnimatedSprite2D.play("playing")
		chica.say("...")
		chica.say("eeeee temazoooooo")
		$DialogueBox.set_callable_on_queue_end(func (): $AnimationPlayer.play("chicaSeVa"))
		

func _on_cortina_y_cuadro_interact() -> void:
	$Player.active = false
	$AnimationPlayer.play("preatropellao")
	pibe.say("che hay algo acá")
	$CortinaYCuadro/AnimatedSprite2D.play("open")
	$CortinaYCuadro/AnimatedSprite2D2.play("open")


func _on_pishito_interact() -> void:
	if not agarrasteLaChapa:
		pibe.say("PISHITO 😍")
		$Pishito/AnimatedSprite2D.play("Bark")
		perro.say("waf")
		$DialogueBox.set_callable_on_queue_end(func (): $Pishito/AnimatedSprite2D.play("Idle"))
	elif not vinoElPerritoConELDisco:
		vinoElPerritoConELDisco = true
		$AnimationPlayer.play("TirarChapa")
	else:
		agarrasteElDisco = true
		pibe.say("ohh un disco :O")
		pibe.say("gracias amigo, buen chico <3")
		perro.say("waf! :3")
		$Pishito/AnimatedSprite2D.play("Idle")

func _on_auto_roto_interact() -> void:
	pibe.say(":O se salió el cosito este de la rueda")
	pibe.say("creo que este pishito quiere que se lo tire!")
	agarrasteLaChapa = true

func _on_animated_sprite_2d_animation_finished() -> void:
	pibe.say("omg un cuadro")
	$DialogueBox.set_callable_on_queue_end(
		func (): $CortinaYCuadro/PinturaAuto.play("default")
		)

func _on_pintura_auto_animation_finished() -> void:
	pibe.say("AAAAAAAAAAAA")
	$AnimationPlayer.play("atropellao")


func _on_salida_body_entered(body: Node2D) -> void:
	if body is Player:
		change_level = true
		next_level = 3 #TODO: agregar nivel final
