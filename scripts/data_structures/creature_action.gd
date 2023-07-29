extends RefCounted
class_name CreatureAction

var can_interrupt: bool = false

var init_action: Callable = _blank
var repeated_action: Callable = _blank_delta
var final_action: Callable = _blank

var action_finished_check: Callable = _blank
var finished: bool = false

var _call_init_action: bool = true

func act(delta:float) -> void:
	if (!finished):
		if (_call_init_action):
			init_action.call()
			_call_init_action = false
		repeated_action.call(delta)
		
		if (action_finished_check.call()):
			finished = true

func _blank():
	return false

func _blank_delta(_delta:float):
	return false
