extends Node3D

@onready
var play_button: Button = $Button

@onready
var islander: Islander = $IslanderRoot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.button_up.connect(_play)


func _play() -> void:
	islander.say("The quick brown fox jumps over the lazy dog")
