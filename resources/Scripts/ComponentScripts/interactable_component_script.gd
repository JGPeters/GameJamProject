extends component
class_name interactable_component

func _ready() -> void:
	get_owner().add_to_group("Interactables")
	get_owner().set_meta("Interactable", true)
	get_owner().set_meta("InteractionType", "Grab")

func init(param_) -> void:
	for child in get_children():
		if child is component:
			child.init(null)
