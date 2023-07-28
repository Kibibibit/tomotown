extends Control


@onready
var tests_button : Button = $CenterContainer/VBoxContainer/HBoxContainer/TestsButton

@onready
var play_button : Button = $CenterContainer/VBoxContainer/PlayButton

@onready
var verbose_checkbox : CheckBox = $CenterContainer/VBoxContainer/HBoxContainer/VerboseCheckBox

func _ready():
	if (OS.is_debug_build()):
		tests_button.disabled = false
	
	tests_button.button_up.connect(_run_tests)

func _run_tests():
	TestRunner.run_tests(verbose_checkbox.button_pressed)
