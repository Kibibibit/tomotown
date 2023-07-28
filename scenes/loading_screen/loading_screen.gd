extends Control


@onready
var tests_button : Button = $CenterContainer/VBoxContainer/TestsButton

@onready
var play_button : Button = $CenterContainer/VBoxContainer/PlayButton


func _ready():
	if (OS.is_debug_build()):
		tests_button.disabled = false
	
	tests_button.button_up.connect(_run_tests)

func _run_tests():
	TestRunner.run_tests()
