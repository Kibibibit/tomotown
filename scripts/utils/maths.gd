extends RefCounted
class_name Maths

static func floor_to_n(value, n) -> int:
	Assert.not_equals(n,0,"Cannot floor to nearest 0!")
	return floori(floori(value * (1/float(n))) / (1/float(n)))
