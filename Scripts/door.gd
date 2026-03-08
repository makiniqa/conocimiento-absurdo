extends AnimatedSprite2D
class_name Door

## si la puerta se puede abrir
@export
var active: bool
## si la puerta está abierta
@export
var isOpen: bool

var isInsideInteractRadius := false

var animationPlayer: AnimationPlayer

signal entered(where: Door)

func _init() -> void:
	pass

func _ready():
	for child in self.get_children():
		if child is AnimationPlayer:
			animationPlayer = child

func interact() -> void:
	if active and not isOpen:
		open()
	elif not active:
		pass
	pass

func open():
	play("open")

	
func _process(delta: float) -> void:
	if animation == "open" and not is_playing():
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		isOpen = true
	if isInsideInteractRadius and isOpen:
		entered.emit(self)
		
	
func activate():
	pass

func _input(event: InputEvent) -> void:
	if active and not isOpen and isInsideInteractRadius:
		if event is InputEventKey and event.is_pressed() and event.keycode in [KEY_Z, KEY_SPACE, KEY_ENTER]:
				open()

func _on_area_2d_body_entered(body: Node2D) -> void:
	isInsideInteractRadius = true
	if isOpen:
		entered.emit(self)

func _on_area_2d_body_exited(body: Node2D) -> void:
	isInsideInteractRadius = false
