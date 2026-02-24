extends CharacterBody2D
class_name Player

@export
var active := true

var direction: = Vector2.DOWN
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation_tree: AnimationTree = $AnimationTree


func _physics_process(delta: float) -> void:
	if not active:
		return
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
		var direction_flipped = Vector2(direction.x, -direction.y)
		animation_tree.set("parameters/StateMachine/IdleState/blend_position", direction_flipped)
		animation_tree.set("parameters/StateMachine/MoveState/blend_position", direction_flipped)
	else:
		velocity = Vector2.ZERO

	move_and_slide()
