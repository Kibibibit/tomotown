extends Creature
class_name Islander

@onready
var voice_gen: VoiceGen3D = $VoiceGen3D

func _process(delta: float) -> void:
	voice_gen.transform = skeleton.get_bone_global_pose(head_bone)
	super(delta)

func say(text:String) -> void:
	voice_gen.play(text)
