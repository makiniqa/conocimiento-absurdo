extends Sprite2D
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
	isOpen = true
	if animationPlayer != null:
		animationPlayer.play("open")
	pass
	
func activate():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	isInsideInteractRadius = true
	if isOpen:
		entered.emit(self)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if active and not isOpen and isInsideInteractRadius:
		if event is InputEventMouseButton:
			if event.is_pressed() and event.button_index == 1:
				open()
				
func _on_area_2d_body_exited(body: Node2D) -> void:
	isInsideInteractRadius = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
