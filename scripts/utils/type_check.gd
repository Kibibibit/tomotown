extends RefCounted
class_name TypeCheck

static func is_number(value) -> bool:
	return value is int || value is float
