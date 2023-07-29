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
var head_bone: int
var has_look_target: bool = false
var look_target: Vector3
var eye_height: float = 5.0
var look_speed: float = 10.0
var _head_override: float = 0.0
var max_neck_angle: float = PI/2.0


var action_queue: Array[CreatureAction] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	head_bone = skeleton.find_bone(HEAD_BONE)
	animation_player.play("Idle")

func _process(delta: float) -> void:
	_process_action(delta)
	_move_head(delta)

func _process_action(delta:float)->void:
	if (!action_queue.is_empty()):
		var current_action: CreatureAction = action_queue.front()
		if (current_action.finished || (current_action.can_interrupt && action_queue.size() > 1)):
			current_action.final_action.call()
			action_queue.pop_front()
			if (!action_queue.is_empty()):
				current_action = action_queue.front()
				current_action.act(delta)
		else:
			current_action.act(delta)

# makes this creature walk to a specific spot
func _set_move_target(_delta: float, _location: Vector2) -> void:
	pass

# makes this creature look at a specific point
func _set_look_target(location: Vector3, _look_speed: float = -1.0) -> void:
	look_target = location
	has_look_target = true
	_head_override = 0.0
	if (_look_speed >= 0.0):
		look_speed = _look_speed
	
	
func _unset_look_target() -> void:
	has_look_target = false

func _move_head(delta:float) -> void:
	if (has_look_target):
		# There has to be a better way to do this?
		var bone_parent: Transform3D = skeleton.get_bone_global_pose(skeleton.get_bone_parent(head_bone))
		var bone_pose: Transform3D =  skeleton.get_bone_global_pose(head_bone)
		var rot = skeleton.get_bone_pose_rotation(head_bone) # Save rotation for after we rotate
		
		var angle := (transform.basis.orthonormalized().get_rotation_quaternion().inverse() * Quaternion( 
				(bone_pose*transform).looking_at(
					look_target-Vector3(0,eye_height,0), 
					Vector3.UP, 
					true
				).basis
			))
		# Stops them from snapping their necks
		var neck_angle = angle.angle_to(rot)
		if  neck_angle > max_neck_angle:
			angle = angle.slerp(
				rot, 
				(neck_angle-max_neck_angle)/neck_angle
			)
		skeleton.set_bone_pose_rotation( #Rotate to face camera
			head_bone, 
			angle
		)
		var looking := bone_parent * skeleton.get_bone_pose(head_bone) # Get the pose we were at
		skeleton.set_bone_pose_rotation(head_bone, rot) # Reset the location
		skeleton.set_bone_global_pose_override(head_bone, looking, _head_override) # Now we can set it as an override
		
		_head_override = lerp(_head_override, 1.0, delta*look_speed)
	else:
		var bone_pose : Transform3D = skeleton.get_bone_global_pose_override(head_bone)
		skeleton.set_bone_global_pose_override(head_bone, bone_pose, _head_override)
		_head_override = lerp(_head_override, 0.0, delta*look_speed)

func add_look_action(target: Vector3, _look_speed: float = -1.0) -> void:
	var act: CreatureAction = CreatureAction.new()
	act.init_action = _set_look_target.bind(target,_look_speed)
	act.can_interrupt = true
	
	var act2 := CreatureAction.new()
	act2.init_action = _unset_look_target
	act2.action_finished_check = _is_look_reset
	act.final_action = insert_action.bind(act2)
	action_queue.append(act)

func force_interrupt_action() -> void:
	if (!action_queue.is_empty()):
		var current_action = action_queue.front()
		current_action.finished = true

func insert_action(act: CreatureAction) -> void:
	action_queue.insert(1, act)

func _is_look_reset() -> bool:
	return _head_override < 0.05
