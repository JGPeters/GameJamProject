extends State

signal grabbed_object(movement_restrictions : Dictionary)
signal released_object()
signal grab_failed()

@export var component_tree : Node

var actor : Node2D
var grabbing : bool = false
var moving: bool = false
var object_that_is_grabbed : Object
var tile_maps : Array[TileMapLayer]

func _ready() -> void:
	set_physics_process(false)
	actor = component_tree.get_actor()
	animations = ["Grab", "Grab/0", "Grab/1", "Grab/2", "Grab/2/0", "Grab/2/1"]
	$GrabRayCast.add_exception(get_owner())
	get_owner().set_meta("CanGrab", true)
	SignalBus.send_tile_map_move.connect(on_send_tile_map_move)
	
	
func enter_state() -> void:
	tile_maps = actor.get_tile_maps()
	if tile_maps.is_empty():
		emit_signal("grab_failed")
	else:
		grab_or_release()
		if grabbing:
			set_physics_process(true)

func exit_state() -> void:
	if grabbing:
		release_grab()
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var move_dir : Vector2 = get_parent().get_move_dir().normalized()
	if move_dir != Vector2.ZERO and !moving:
		actor.add_collision_exception_with(object_that_is_grabbed)
		object_that_is_grabbed.add_collision_exception_with(actor)
		
		SignalBus.request_tile_map_move.emit(actor, object_that_is_grabbed, move_dir)
		
		#else:
			#camera shake

func on_send_tile_map_move(_actor : PhysicsBody2D, _desintation : Vector2, time : float) -> void:
	moving = true
	var move_dir : Vector2 = get_parent().get_move_dir().normalized()
	actor.set_velocity(move_dir)
	actor.set_last_movement_dir(move_dir)
	await get_tree().create_timer(time).timeout
	moving = false
	actor.set_velocity(Vector2.ZERO)

func grab_or_release() -> void:
	if !grabbing:
		attempt_grab()
	else:
		release_grab()

func check_grab(facing_dir : Vector2) -> Object:
	$GrabRayCast.enabled = true
	$GrabRayCast.transform = actor.get_global_transform()
	$GrabRayCast.target_position = Vector2(10,10) * facing_dir.normalized()
	$GrabRayCast.force_raycast_update()
	var object : Object
	if $GrabRayCast.is_colliding():
		object = $GrabRayCast.get_collider()
		if object.get_meta("Grabbable"):
			return object
		else:
			return null
	else:
		return null

func grab(object : Object):
	grabbing = true
	get_owner().set_grabbing(true)
	var fdir : Vector2 = get_owner().get_facing_dir().normalized()
	var heavy : bool = false
	if object.get_meta("Heavy", false):
		heavy = true
	object_that_is_grabbed = object
	grabbed_object.emit({"x": fdir.x, "y": fdir.y, "Heavy": heavy})
	SignalBus.something_grabbed_a_thing.emit(get_owner(), object)

func check_angle() -> Vector2:
	var fdir : Vector2 = get_owner().get_facing_dir().normalized()
	var valid_angles : Array[Vector2] = [Vector2(0, 1), Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1)]
	if fdir in valid_angles:
		return fdir
	else:
		return Vector2.ZERO

func attempt_grab() -> void:
	var fdir = check_angle()
	if fdir != Vector2.ZERO:
		var object : Object = check_grab(fdir)
		if object:
			grab(object)
		else:
			grab_failed.emit()

func release_grab() -> void:
	grabbing = false
	get_owner().set_grabbing(false)
	$GrabRayCast.enabled = false
	actor.remove_collision_exception_with(object_that_is_grabbed)
	object_that_is_grabbed.remove_collision_exception_with(actor)
	released_object.emit()
	SignalBus.something_released_a_thing.emit(get_owner(), object_that_is_grabbed)
	
