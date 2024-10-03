extends component
class_name velocity_component

@export var max_speed: float = 100
@export var acceleration_coefficient: float = 10
@export var debug_mode: bool = false

var velocity: Vector2
var velocity_override: Vector2
var speed_multiplier: float = 1
var speed_precent_modifier: float:
	get:
		return _speed_percent_modifier.values().reduce(sum_float, 0)
var acceleration_coefficient_multiplier: float = 1

var speed_percent: float:
	get:
		return min(velocity.length() / (calculated_max_speed if calculated_max_speed > 0.0 else 1.0), 1.0)
var calculated_max_speed: float:
	get:
		return max_speed * (1.0 + speed_precent_modifier) * speed_multiplier

var _speed_percent_modifier: Dictionary = {}

var current_delta : float

func sum_float(a: float, b: float) -> float:
	return a + b

func _notification(what: int) -> void:
	if(what == NOTIFICATION_SCENE_INSTANTIATED):
		init([])

func _ready() -> void:
	set_process(false)
	if OS.is_debug_build() && debug_mode:
		if owner is Node2D:
			owner.connect("draw", Callable(self, "_on_debug_draw"))
		
		set_process(true)
	
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	current_delta = delta
	#print(velocity)
	

func accelerate_to_velocity(target_velocity: Vector2, delta:float) -> void:
	# Apply acceleration toward the target velocity
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-acceleration_coefficient * acceleration_coefficient_multiplier * delta))

	# Clamp the velocity to ensure it does not exceed the calculated maximum speed
	if velocity.length() > calculated_max_speed:
		velocity = velocity.normalized() * calculated_max_speed

func accerlerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * calculated_max_speed, current_delta)
	#print(direction)
	#print(direction * calculated_max_speed)
	#print(current_delta)

func get_max_velocity(direction:Vector2) -> Vector2:
	return direction * calculated_max_speed

func maximize_velocity(direction:Vector2) -> void:
	velocity = get_max_velocity(direction)

func decelerate() -> void:
	accelerate_to_velocity(Vector2.ZERO, current_delta)

func move(character_body:CharacterBody2D) -> void:
	#print(character_body)
	#print(velocity_override)
	#print(velocity)
	if velocity_override != Vector2.ZERO:
		#print("null")
		character_body.velocity = velocity_override
	else:
		character_body.velocity = velocity
	character_body.move_and_slide()

func set_max_speed(new_speed: float) -> void:
	max_speed = new_speed

func add_speed_percent_modifier(incoming_name:String, change:float) -> void:
	var current_value = 0.0
	if _speed_percent_modifier.has(incoming_name):
		current_value = _speed_percent_modifier[incoming_name]
	
	current_value += change
	_speed_percent_modifier[incoming_name] = current_value

func set_speed_percent_modifier(incoming_name:String, val:float) -> void:
	_speed_percent_modifier[incoming_name] = val

func get_speed_percent_modifier(incoming_name:String, _val:float) -> float:
	var modifier = 0.0
	if _speed_percent_modifier.has(incoming_name):
		modifier = _speed_percent_modifier[incoming_name]
	return modifier

func _on_debug_draw() -> void:
	if owner is Node2D:  # Check if owner is Node2D
		owner.draw_line(Vector2.ZERO, velocity, Color.CYAN, 2.0)
