extends Node
class_name EntityManager

func _ready() -> void:
	SignalBus.something_grabbed_a_thing.connect(on_something_grabbed_a_thing)
	SignalBus.something_released_a_thing.connect(on_something_released_a_thing)

func on_something_grabbed_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	if grabber in get_children() and thing_grabbed in get_children():
		for child in thing_grabbed.get_children():
			if child is CollisionShape2D:
				child.set_meta("GrabbedCollision", true)
				thing_grabbed.reparent(grabber, true)
				child.reparent(grabber, true)

func on_something_released_a_thing(grabber: Node2D, thing_grabbed: Object) -> void:
	if thing_grabbed in grabber.get_children():
		for child in grabber.get_children():
			if child.get_meta("GrabbedCollision", false):
				child.set_meta("GrabbedCollision", null)
				child.reparent(thing_grabbed, true)
		thing_grabbed.reparent(self, true)
