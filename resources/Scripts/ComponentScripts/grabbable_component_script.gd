extends interactable_component

func _ready() -> void:
	get_owner().set_meta("Grabbable", true)
	SignalBus.something_grabbed_a_thing.connect(on_something_grabbed_a_thing)

func on_something_grabbed_a_thing(grabber : Node, thing_grabbed : Object) -> void:

	#if thing_grabbed == self:
	print(grabber)
	self.reparent(get_node("../Gobbo"), false)
