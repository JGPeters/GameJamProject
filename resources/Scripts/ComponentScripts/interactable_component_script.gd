extends component
class_name interactable_component

func _ready() -> void:
	get_owner().add_to_group("Interactables")

func init(param_) -> void:
	for child in get_children():
		if child is component:
			child.init(null)
