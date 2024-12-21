extends component
class_name StateMachine

signal state_changed(new_state: State)

@export var component_tree : Node
@export var start_state : State
@export var grab_state : State
@export var switch_toggle_state : State

var current_state : State
var actor : Node2D
var interacting : bool

func _ready() -> void:
	actor = component_tree.get_actor()
	interacting = false
	if start_state:
		change_state(start_state)
	else:
		print("No starting state assigned to %s" % self)
	
func change_state(new_state : State) -> void:
	if current_state:
		current_state.exit_state()
	new_state.enter_state()
	current_state = new_state
	state_changed.emit(new_state)
	

func _on_interact() -> void:
	if interacting:
		interacting = false
		change_state(start_state)
	else:
		var interaction_type : String = check_interact_type()
		if interaction_type == "None":
			interacting = false
			return
		else:
			match interaction_type:
				"Grab":
					if actor.get_meta("CanGrab", false):
						if grab_state:
							change_state(grab_state)
						else:
							print("No grab state assigned to %s" % self)
				"SwitchToggle":
					if actor.get_meta("CanToggleSwitches", false):
						if switch_toggle_state:
							change_state(switch_toggle_state)
						else:
							print("No switch_toggle_state assigned to %s" % self)
			interacting = true

func check_interact_type() -> String:
	$InteractTypeChecker.enabled = true
	$InteractTypeChecker.global_position = actor.get_global_position()
	$InteractTypeChecker.target_position = Vector2(15,15) * actor.get_facing_dir().normalized()
	$InteractTypeChecker.force_raycast_update()
	if $InteractTypeChecker.is_colliding():
		var object : Object
		object = $InteractTypeChecker.get_collider()
		if object.get_meta("Interactable", false):
			$InteractTypeChecker.enabled = false
			return object.get_meta("InteractionType", "None")
		else:
			$InteractTypeChecker.enabled = false
			return "None"
	else:
		$InteractTypeChecker.enabled = false
		return "None"


func _on_grab_failed() -> void:
	change_state(start_state)
	interacting = false
