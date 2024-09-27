extends component
class_name movement_component


@export var speed = 40
@export var can_move = true

@export var controlled_entity : Node2D
var movement_attributes : Array = []	

func init(_movement_attributes) -> void:
	movement_attributes = _movement_attributes
	for attribute in _movement_attributes:
		if attribute.get_type() == MovementAtributeType.Collision:
			print("yay")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(can_move == false):
		return
	var input_dir = Vector2.ZERO
	controlled_entity.velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("down"):
		input_dir.y += 1
	if Input.is_action_pressed("up"):
		input_dir.y -= 1
		
	if input_dir.length() > 0:
		controlled_entity.velocity = input_dir.normalized() * speed
		
	controlled_entity.move_and_collide(controlled_entity.velocity * delta)
	
func _set_can_move(bVal):
	can_move = bVal
