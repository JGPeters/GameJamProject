extends movement_component
class_name movement_attribute

var attributeType: =  MovementAtributeType.None

func init(_param) -> void:
	attributeType = MovementAtributeType.None

func get_type() -> int:
	return attributeType
