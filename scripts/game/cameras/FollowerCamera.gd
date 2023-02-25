extends Node

export(NodePath) var tween_path = NodePath("Tween")
export(float) var resting_zoom = 0.7 # 70 for 3D cams

onready var tween = get_node(tween_path)
onready var this = get_parent().get_node(name)

var follow_point
var tweening_properties = []
var custom_position = null
var canmove = true

func _ready():
	on_ready()

func on_ready():
	get_node(tween_path).connect("tween_started", self, "_on_cam_tween_started")
	get_node(tween_path).connect("tween_completed", self, "_on_cam_tween_completed")

func on_update():
	if canmove:
		update_movement()
#	update_zoom()

func update_movement():
	if !movement_overriden():
		if (this is Camera):
			this.global_transform.origin = lerp(this.global_transform.origin, get_position_to_follow(), GodotX.get_haxeflixel_lerp(get_movement_lerp()))
		else:
			this.global_position = lerp(this.global_position, get_position_to_follow(), GodotX.get_haxeflixel_lerp(get_movement_lerp()))
	
	if !rotation_overriden():
		if this is Camera:
			var new_quat = this.global_transform.basis.get_rotation_quat().slerp(get_rotation_to_follow(), GodotX.get_haxeflixel_lerp(get_movement_lerp()))
			this.global_transform.basis = Basis(new_quat)

func get_movement_lerp():
	return get_default_movement_lerp()

func get_default_movement_lerp():
	return 1

func get_position_to_follow():
	if custom_position:
		return custom_position.global_position if custom_position is Position2D else custom_position.global_transform.origin
	return follow_point.global_position if follow_point is Position2D else follow_point.global_transform.origin

func get_rotation_to_follow():
	if custom_position:
		return custom_position.global_rotation if custom_position is Position2D else custom_position.global_transform.basis.get_rotation_quat()
	return follow_point.global_rotation if follow_point is Position2D else follow_point.global_transform.basis.get_rotation_quat()

func reset_position(different_pos = null):
	if different_pos is Vector2 || different_pos is Vector3:
		if this is Camera:
			this.global_transform.origin = different_pos
		else:
			this.global_position = different_pos
	else:
		if this is Camera:
			this.global_transform.origin = get_position_to_follow()
		else:
			this.global_position = get_position_to_follow()

func reset_zoom(different_zoom = null):
	if different_zoom is float:
		zoom_axis(different_zoom)
	else:
		zoom_axis(resting_zoom)

func movement_overriden():
	return NodePath(":global_position") in tweening_properties

func rotation_overriden():
	return NodePath(":rotation") in tweening_properties

func zoom_axis(val, axis = 0, fnf_val = true):
	if this is Camera:
		this.fov = val
		return
	
	val = 1.0 / val if fnf_val else val
	
	match axis:
		1:
			this.zoom = Vector2(val, this.zoom.y)
		2:
			this.zoom = Vector2(this.zoom.x, val)
		_:
			this.zoom = Vector2(val, val)

#func zoom_overriden():
#	return NodePath(":zoom") in tweening_properties

func _on_cam_tween_started(obj: Object, key: NodePath):
	if obj == self:
		tweening_properties.append(key)

func _on_cam_tween_completed(obj: Object, key: NodePath):
	if obj == self:
		tweening_properties.erase(key)
