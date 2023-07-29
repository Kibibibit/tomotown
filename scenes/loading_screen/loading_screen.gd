extends Control

# This is a placeholder screen, mostly for keeping somewhere to run unit tests

@onready
var tests_button : Button = $CenterContainer/VBoxContainer/HBoxContainer/TestsButton

@onready
var play_button : Button = $CenterContainer/VBoxContainer/PlayButton

@onready
var verbose_checkbox : CheckBox = $CenterContainer/VBoxContainer/HBoxContainer/VerboseCheckBox

func _ready():
	# We don't want to run unit tests if we're not debugging
	if (OS.is_debug_build()):
		tests_button.disabled = false
	
	_load_config()
	_load_assets()
	
	tests_button.button_up.connect(_run_tests)
	play_button.button_up.connect(_to_test_room)

func _run_tests():
	TestRunner.run_tests(verbose_checkbox.button_pressed)

# TODO: Abstract out into own class
func _load_config() -> void:
	var config = ConfigFile.new()
	var error = config.load("res://config.cfg")
	if (error != OK):
		push_error("FAILED TO LOAD config.cfg")
		push_error(error)
		return
	
	TestRunner.TEST_PATH = config.get_value("test_config","test_path")
	VoiceGen3D.VOICE_PATH = config.get_value("voice_config","voice_path")
	
func _load_assets() -> void:
	VoiceGen3D.load_sounds()

func _to_test_room() -> void:
	get_tree().change_scene_to_file("res://scenes/islander_room/islander_room.tscn")
