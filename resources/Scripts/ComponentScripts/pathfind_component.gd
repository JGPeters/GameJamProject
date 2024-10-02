extends component
class_name pathfind_component

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D # Automatically fetch the node from the scene 
@onready var interval_timer: Timer = $IntervalTimer # Automatically fetch the node from the scene 
@export var velocity_comp: velocity_component # Exported variable for the editor 
@export var debug_draw_enabled: bool # Exported variable for the editor
@export var root_node: Node2D

func _notification(what: int) -> void:
	if(what == NOTIFICATION_SCENE_INSTANTIATED):
		init([])
		
func _ready() -> void:
	navigation_agent.velocity_computed.connect(on_velocity_computed)

func _draw() -> void:
	if OS.is_debug_build() && debug_draw_enabled:
		pass

#func _process(_delta: float) -> void:
	#()

func set_target_position(target_position: Vector2) -> void:
	print(interval_timer.is_stopped())
	if !interval_timer.is_stopped():
		return
	interval_timer.start()
	navigation_agent.target_position = target_position

func force_set_target_position(target_position) -> void:
	navigation_agent.target_position = target_position
	interval_timer.start()

func follow_path() -> void:
	if navigation_agent.is_navigation_finished():
		velocity_comp.decelerate()
		return;
		
	var direction = (navigation_agent.get_next_path_position() - root_node.global_position).normalized()
	velocity_comp.accerlerate_in_direction(direction)
	navigation_agent.velocity = velocity_comp.velocity

func on_velocity_computed(velocity: Vector2) -> void:
	print(velocity)
	var new_direction = velocity.normalized()
	var current_direction = velocity_comp.velocity.normalized()
	var halfway = new_direction.lerp(current_direction, 1.0 - exp(velocity_comp.acceleration_coefficient * velocity_comp.current_delta))
	velocity_comp.velocity = halfway * velocity_comp.velocity.length()
