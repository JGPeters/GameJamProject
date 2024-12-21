extends State

@export var component_tree : Node

var actor : Node2D

func _ready() -> void:
	actor = component_tree.get_actor()
	set_physics_process(false)
	actor = component_tree.get_actor()
	animations = ["Walk", "Idle"]

func enter_state() -> void:
	set_physics_process(true)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var move_dir : Vector2 = get_parent().get_move_dir()
	actor.set_velocity(move_dir * actor.get_speed() * delta)
	actor.set_last_movement_dir(move_dir)
	if move_dir != Vector2.ZERO:
		actor.set_facing_dir(move_dir)
	actor.move_and_slide()
