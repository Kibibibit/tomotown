extends Node3D

@onready
var play_button: Button = $Button

@onready
var look_button: Button = $Button2

@onready
var islander: Islander = $IslanderRoot

@onready
var camera: Camera3D = $Camera3D

@onready
var eye_height: VSlider = $VSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.button_up.connect(_play)
	look_button.button_up.connect(_look_at_camera)

func _process(_delta: float) -> void:
	islander.eye_height = eye_height.value

func _play() -> void:
	islander.say("The quick brown fox jumps over the lazy dog")

func _look_at_camera() -> void:
	if (islander.has_look_target):
		islander.unset_look_target()
	else:
		islander.set_look_target(camera.position)
