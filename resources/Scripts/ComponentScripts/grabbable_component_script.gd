extends interactable_component

func _ready() -> void:
	get_owner().set_meta("Grabbable", true)
