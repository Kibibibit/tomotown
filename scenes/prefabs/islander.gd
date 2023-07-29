extends Creature
class_name Islander

@onready
var voice_gen: VoiceGen3D = $VoiceGen3D

func say(text:String) -> void:
	voice_gen.play(text)
