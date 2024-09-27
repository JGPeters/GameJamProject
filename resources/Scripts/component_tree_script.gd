extends Node2D
class_name component

enum MovementAtributeType{
	Collision
}
func init(_param) -> void:
	pass
	for comp in get_children():
		comp.init(null)
