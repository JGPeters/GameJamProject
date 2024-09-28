extends Node2D
class_name component

enum MovementAtributeType{
	Collision
}
func init(_param) -> void:
	pass
	for comp in get_children():
		if comp is movement_attributes:
			print("Movement attribute found:", comp.get_type())
			#comp.init(comp.get_type())
			return
		comp.init(null)
