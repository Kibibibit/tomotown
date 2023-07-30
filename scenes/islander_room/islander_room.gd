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
var look_button2: Button = $Button3

@onready
var unlook_button: Button = $Button4

@onready
var light: DirectionalLight3D = $DirectionalLight3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.button_up.connect(_play)
	look_button.button_up.connect(_look_at_camera)
	look_button2.button_up.connect(_look_at_light)
	unlook_button.button_up.connect(_unlook)

func _play() -> void:
	islander.say("The quick brown fox jumps over the lazy dog")

func _look_at_camera() -> void:
	islander.add_look_action(camera.position)

func _look_at_light() -> void:
	islander.add_look_action(light.position)

func _unlook() -> void:
	islander.add_unlook_action()
