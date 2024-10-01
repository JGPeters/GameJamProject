extends Node
class_name EntityManager

func _ready() -> void:
	SignalBus.something_grabbed_a_thing.connect(on_something_grabbed_a_thing)
	SignalBus.something_released_a_thing.connect(on_something_released_a_thing)

func on_something_grabbed_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	if grabber in get_children() and thing_grabbed in get_children():
		thing_grabbed.reparent(grabber, true)

func on_something_released_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	if thing_grabbed in grabber.get_children():
		thing_grabbed.reparent(self, true)
