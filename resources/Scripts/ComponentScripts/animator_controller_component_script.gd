extends component
class_name Animator_Controller

@export var animation_tree : AnimationTree
@export var actor : CharacterBody2D

var available_animations : Array[String]

func _on_movement_state_changed(new_state: State) -> void:
	available_animations = new_state.get_animations()
	var new_animations : Array[String]
	for animation in available_animations:
		var new_animation = "parameters/%s/blend_position" % animation 
		new_animations.append(new_animation)
	available_animations = new_animations

func _physics_process(_delta: float) -> void:
	for animation : String in available_animations:
		if get_owner().get_meta("CanGrab", false) and get_owner().get_grabbing():
			if animation == "parameters/Grab/blend_position" or animation == "parameters/Grab/2/blend_position":
				animation_tree.set(animation, push_or_pull(animation))
			else:
				animation_tree.set(animation, get_owner().get_facing_dir())
		else:
			animation_tree.set(animation, get_owner().get_facing_dir())
		
func push_or_pull(animation: String) -> int:
	if not get_owner().velocity and animation != "parameters/Grab/2/blend_position":
		return 0
	if get_owner().get_facing_dir() == get_owner().get_last_movement_dir():
		return 1
	else:
		return -1
	
