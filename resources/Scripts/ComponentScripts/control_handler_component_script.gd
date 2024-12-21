extends component

signal Interact()

@export var component_tree : Node

var actor : Node2D

func _ready() -> void:
	actor = component_tree.get_actor()

func get_move_dir() -> Vector2:
	var input_dir = Vector2.ZERO
	if actor.get_can_move_x() and Input.is_action_pressed("right"):
		input_dir.x += 1
	if actor.get_can_move_x() and Input.is_action_pressed("left"):
		input_dir.x -= 1
	if actor.get_can_move_y() and Input.is_action_pressed("down"):
		input_dir.y += 1
	if actor.get_can_move_y() and Input.is_action_pressed("up"):
		input_dir.y -= 1
	return input_dir.normalized()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		Interact.emit()
