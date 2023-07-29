extends Node3D
class_name Creature

const HEAD_BONE := "Head"

var creature_data: CreatureData

var has_look_target: bool = false
var look_target: Vector3
var head_bone: int

var _head_override: float = 0.0

var eye_height: float = 2.0
var look_speed: float = 10.0

@onready
var mesh: Node3D = $Mesh
@onready
var skeleton: Skeleton3D = $Mesh/Armature/Skeleton3D
@onready
var animation_player: AnimationPlayer = $Mesh/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	head_bone = skeleton.find_bone(HEAD_BONE)
	animation_player.play("Idle")

func _process(_delta: float) -> void:
	_move_head(_delta)

# makes this creature walk to a specific spot
func set_move_target(_location: Vector2) -> void:
	pass

# makes this creature look at a specific point
func set_look_target(location: Vector3, _look_speed: float = -1.0) -> void:
	look_target = location
	has_look_target = true
	if (_look_speed >= 0.0):
		look_speed = _look_speed
	
	
func unset_look_target() -> void:
	has_look_target = false

func _move_head(delta:float) -> void:
	if (has_look_target):
		# There has to be a better way to do this?
		var skeleton_t = skeleton.global_transform
		var bone_parent: Transform3D = skeleton.get_bone_global_pose(skeleton.get_bone_parent(head_bone))
		var bone_pose: Transform3D =  skeleton_t*skeleton.get_bone_pose(head_bone).translated_local(Vector3(0,eye_height,0))
		var rot = skeleton.get_bone_pose_rotation(head_bone)
		skeleton.set_bone_pose_rotation(
			head_bone, 
			Quaternion( 
				bone_pose.looking_at(
					look_target, 
					Vector3.UP, 
					true
				).basis
			)
		)
		var looking := bone_parent * skeleton.get_bone_pose(head_bone)
		skeleton.set_bone_pose_rotation(head_bone, rot)
		skeleton.set_bone_global_pose_override(head_bone, looking, _head_override)
		
		_head_override = lerp(_head_override, 1.0, delta*look_speed)
	else:
		var bone_pose : Transform3D = skeleton.get_bone_global_pose_override(head_bone)
		skeleton.set_bone_global_pose_override(head_bone, bone_pose, _head_override)
		_head_override = lerp(_head_override, 0.0, delta*look_speed)
	
