extends Node

class_name movement_attributes

enum MovementAtributeType {
	Collision,
	#SpeedBoost,
	#Other
}

func get_type() -> MovementAtributeType:
	return MovementAtributeType.Collision  # Return appropriate type
