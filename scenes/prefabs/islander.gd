extends CreatureParent
class_name Islander

@onready
var voice_gen: VoiceGen3D = $VoiceGen3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func say(text:String) -> void:
	voice_gen.play(text)
