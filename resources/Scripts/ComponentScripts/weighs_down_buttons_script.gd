extends component


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_owner().set_meta("WeighsDownButtons", true)
