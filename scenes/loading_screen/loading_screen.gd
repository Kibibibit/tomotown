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
	
	tests_button.button_up.connect(_run_tests)

func _run_tests():
	TestRunner.run_tests(verbose_checkbox.button_pressed)
