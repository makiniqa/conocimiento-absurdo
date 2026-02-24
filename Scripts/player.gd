extends CharacterBody2D
class_name Player

const SPEED = 150.0

@export
var active := true
@export
var direction: = Vector2.DOWN
@onready var animation_tree: AnimationTree = $AnimationTree

func _physics_process(delta: float) -> void:
	if active:
		direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
		var direction_flipped = Vector2(direction.x, -direction.y)
		animation_tree.set("parameters/StateMachine/IdleState/blend_position", direction_flipped)
		animation_tree.set("parameters/StateMachine/MoveState/blend_position", direction_flipped)
	elif not active or not direction:
		velocity = Vector2.ZERO
	if active:
		move_and_slide()
