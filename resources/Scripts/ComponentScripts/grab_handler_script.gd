extends Node

signal grabbed_object(movement_restrictions : Dictionary)
signal released_object()
signal grab_failed()

var grabbing : bool = false
var object_that_is_grabbed : Object

func _ready() -> void:
	$GrabRayCast.add_exception(get_owner())
	get_owner().set_meta("CanGrab", true)

func grab_or_release() -> void:
	if !grabbing:
		print("attempting grab")
		attempt_grab()
	else:
		print("releasing grab")
		release_grab()

func check_grab(facing_dir : Vector2) -> Object:
	$GrabRayCast.enabled = true
	$GrabRayCast.transform = get_owner().transform
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
	print("grabbing")
	grabbing = true
	var fdir : Vector2 = get_owner().get_last_facing_dir().normalized()
	var heavy : bool = false
	if object.get_meta("Heavy"):
		heavy = true
	object_that_is_grabbed = object
	grabbed_object.emit({"x": fdir.x, "y": fdir.y, "Heavy": heavy})
	SignalBus.something_grabbed_a_thing.emit(get_owner(), object)

func check_angle() -> Vector2:
	var fdir : Vector2 = get_owner().get_last_facing_dir().normalized()
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
			print("grab failed")
			grab_failed.emit()

func release_grab() -> void:
	grabbing = false
	$GrabRayCast.enabled = false
	released_object.emit()
	SignalBus.something_released_a_thing.emit(get_owner(), object_that_is_grabbed)
