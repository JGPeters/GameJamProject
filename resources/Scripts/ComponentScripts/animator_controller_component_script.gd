extends component
class_name Animator_Controller

@export var animation_tree : AnimationTree
@export var actor : CharacterBody2D

var available_animations : Array[String]

func _on_movement_state_machine_state_changed(new_state: State) -> void:
	available_animations = new_state.get_animations()
	var new_animations : Array[String]
	for animation in available_animations:
		var new_animation = "parameters/%s/blend_position" % animation 
		new_animations.append(new_animation)
	available_animations = new_animations
	
var last_facing_direction := Vector2(0, -1)

func _physics_process(_delta: float) -> void:
	for animation in available_animations:
		animation_tree.set(animation, actor.get_last_facing_dir())
	
	
