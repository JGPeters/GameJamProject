extends component
class_name StateMachine

signal state_changed(new_state : State)

@export var start_state : State

var current_state : State

func init(_param) -> void:
	if start_state:
		change_state(start_state)
	else:
		print("No starting state assigned to %s" % self)
	
func change_state(new_state : State) -> void:
	if current_state:
		current_state.exit_state()
	new_state.enter_state()
	state_changed.emit(new_state)
	current_state = new_state
