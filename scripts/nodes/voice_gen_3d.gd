extends Node3D
class_name VoiceGen3D

# This script really needs some cleanup

const VOICE_FOLDER_PREFIX := "VOICE_"

const _letters: String = "abcdefghijklmnopqrstuvwxyz"
const _numbers = {
	"0":"zero",
	"1":"one",
	"2":"two",
	"3":"three",
	"4":"four",
	"5":"five",
	"6":"six",
	"7":"seven",
	"8":"eight",
	"9":"nine"
}

static var VOICE_PATH: String
static var _sounds: Dictionary = {}
static var voices: Array[StringName]

var _queue:Array = []
var _pitch_curve: Array = []
var _timer: Timer
var _player: AudioStreamPlayer3D

@export_group("Voice Settings")

## This is the base pitch that the voice will be played at, as a multiplier of the base
## audio's pitch. This will also increase the speed of the player.
@export var pitch: float

## The pitch multiplier [pitch] will be modified up and down by up to this amount randomly
## on each letter.
@export var pitch_range: float

## This is the time in seconds each letter is played for.
@export var speed: float

## This is the amount the pitch multiplier will increase by for each letter at the end of a question.
@export var question_pitch: float
## This is how many letters before a question mark the pitch will rise for
@export var question_length: int
## This choses which voice from [voices] will play
@export var voice: int = 0

signal finished

var playing : bool :
	get:
		return _player.playing
	set(_playing):
		_player.playing = _playing


static func load_sounds():
	var directory: DirAccess = DirAccess.open(VOICE_PATH)
	
	if (directory == null):
		return DirAccess.get_open_error()
	voices = []
	for v in directory.get_directories():
		if (v.begins_with(VOICE_FOLDER_PREFIX)):
			_load_voice(StringName(v))

static func _load_voice(voice_name: StringName) -> void:
	voices.append(voice_name)
	_sounds[voice_name] = {}
	var directory: DirAccess = DirAccess.open("%s/%s" % [VOICE_PATH, voice_name])
	if (directory == null):
		return DirAccess.get_open_error()
	var sounds = directory.get_files()
	
	for letter in _letters:
		var found_letter = false
		for sound in sounds:
			if (sound.begins_with("%s." % letter) && !sound.ends_with(".import")):
				_sounds[voice_name][StringName(letter)] = load("%s/%s/%s" % [VOICE_PATH, voice_name, sound])
				found_letter = true
				break
		if (!found_letter):
			push_warning("Could not find letter '%s' in voice '%s'!" % [letter, voice_name])

func _ready() -> void:
	_timer = Timer.new()
	_timer.autostart = false
	_timer.one_shot = true
	_timer.name = "Timer"
	_timer.timeout.connect(_play_sound)
	add_child(_timer)
	_player = AudioStreamPlayer3D.new()
	_player.finished.connect(_finished)
	add_child(_player)

func generate_text(text:String) -> String:
	for number in _numbers.keys():
		while (text.contains(number)):
			text = text.replace(number, _numbers[number])
	return text.to_lower()

func play(text: String):
	if (voices.is_empty()):
		push_error("No voices are loaded! Try using .load_voices or .load_voice first!")
		return
	stop()
	
	_queue = generate_text(text).split()
	_pitch_curve = []
	## Handling pithc changes
	for i in range(0,_queue.size()):
		_pitch_curve.append(max(0.01, pitch + randf_range(-pitch_range,pitch_range)))
		## if its a question mark, go back a few steps and raise the pitch
		if (_queue[i] == "?"):
			for q in question_length:
				if (i-q > 0):
					var mult = question_length-q
					_pitch_curve[i-q-1] = pitch + question_pitch*(mult)
					
	_play_sound()

func stop():
	_timer.stop()
	_player.stop()
	_queue = []


func _play_sound():
	_player.stop()
	if (_queue.is_empty()):
		return
	var c = _queue.pop_front()
	var p = _pitch_curve.pop_front()
	if (_sounds[voices[voice]].has(c)):
		_player.pitch_scale = p
		_player.stream = _sounds[voices[voice]][c]
		_player.play()
	
	_timer.start(speed)

func _finished():
	finished.emit()
