extends Node3D
class_name Creature

const HEAD_BONE := "Head"

@onready
var mesh: Node3D = $Mesh
@onready
var skeleton: Skeleton3D = $Mesh/Armature/Skeleton3D
@onready
var animation_player: AnimationPlayer = $Mesh/AnimationPlayer

var creature_data: CreatureData

# Look vars
# The index of their head bone
var head_bone: int
# Are they currently trying to look at something?
var is_looking: bool = false
# Where their head is currently aiming
var head_vector: Vector3
# Where they're trying to look
var look_target: Vector3
# Whether or not their look vector should be lerped or set
var has_look_vector: bool = false
# How fast do they look?
var look_speed: float = 10.0
# The weight of the animation vs the head override
var _head_override: float = 0.0
# Maximum angle they can look
var max_neck_angle: float = PI/2.0


var action_queue: Array[Callable] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	head_bone = skeleton.find_bone(HEAD_BONE)
	animation_player.play("Idle")

func _process(delta: float) -> void:
	_process_action()
	_move_head(delta)

func _process_action()->void:
	if (!action_queue.is_empty()):
		var action: Callable = action_queue.pop_front()
		action.call()

# makes this creature walk to a specific spot
func _set_move_target(_delta: float, _location: Vector2) -> void:
	pass

# makes this creature look at a specific point
func _set_look_target(location: Vector3, _look_speed: float = -1.0) -> void:
	look_target = location
	is_looking = true
	if (_look_speed >= 0.0):
		look_speed = _look_speed
	
	
func _unset_look_target() -> void:
	is_looking = false
	has_look_vector = false

func _move_head(delta:float) -> void:
	if (is_looking):
		# If `has_look_vector` is unset, that means rather than lerping we want to snap the vector
		if (!has_look_vector):
			head_vector = look_target
			has_look_vector = true
		
		# Having bone parent makes it easier to do some transforms later
		var bone_parent: Transform3D = skeleton.get_bone_global_pose(skeleton.get_bone_parent(head_bone))
		var bone_pose: Transform3D =  skeleton.get_bone_global_pose(head_bone)

		# Save rotation for after we rotate
		var rot = skeleton.get_bone_pose_rotation(head_bone) 

		# Get the inverse of the islander's transform so we can use it to scale things when we're done
		var transform_inverse_quat: Quaternion = transform.basis.orthonormalized().get_rotation_quaternion().inverse()

		# The angle we're looking at but in global space
		var look_quat: Quaternion = Quaternion((bone_pose*transform).looking_at(head_vector, Vector3.UP, true).basis)
		# The angle but now in local space
		var angle := transform_inverse_quat * look_quat
		# Stops them from snapping their necks
		var neck_angle = angle.angle_to(rot)
		if  neck_angle > max_neck_angle:
			angle = angle.slerp(
				rot, 
				(neck_angle-max_neck_angle)/neck_angle
			)
		
		# Apply the rotation
		skeleton.set_bone_pose_rotation(head_bone, angle)
		# Get the pose for applying as global pose
		var looking := bone_parent * skeleton.get_bone_pose(head_bone) 
		# Reset the pose as `set_bone_pose_rotation` sets the whole pose and not the override
		skeleton.set_bone_pose_rotation(head_bone, rot)
		# Use the pose we saved earlier and apply as an override
		skeleton.set_bone_global_pose_override(head_bone, looking, _head_override) # Now we can set it as an override
		
		head_vector = head_vector.slerp(look_target,delta*look_speed)
		_head_override = lerp(_head_override, 1.0, delta*look_speed)
	else:
		var bone_pose : Transform3D = skeleton.get_bone_global_pose_override(head_bone)
		skeleton.set_bone_global_pose_override(head_bone, bone_pose, _head_override)
		_head_override = lerp(_head_override, 0.0, delta*look_speed)

func add_look_action(target: Vector3, _look_speed: float = -1.0) -> void:
	var act: Callable = _set_look_target.bind(target, _look_speed)
	action_queue.append(act)

func add_unlook_action() -> void:
	var act: Callable = _unset_look_target
	action_queue.append(act)

func _is_look_reset() -> bool:
	return _head_override < 0.05
