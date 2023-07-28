extends RefCounted
class_name Assert

# Asserting can be annoying to hand write
# so this script contains useful assert methods

const ASSERT_FAILED_MESSAGE = "ASSERTION FAILED: "

# This function actually runs the assert, and prints an optional message
static func _do_assert(condition:bool, error: String, message:String) -> bool:
	assert(condition, "%s %s %s" % [ASSERT_FAILED_MESSAGE,error, message])
	return condition

# Checks if minV <= value < maxV
static func in_range(
	value, 
	minV, 
	maxV,
	message:String = ""
) -> bool:
	return _do_assert(
		minV <= value && value < maxV,
		"in_range: %s not in range [%s,%s)" % [value, minV, maxV],
		message
	)
# Checks if minV <= value <= maxV
static func in_range_inclusive(
	value,
	minV,
	maxV,
	message:String = ""
) -> bool:
	return _do_assert(
		minV <= value && value <= maxV,
		"in_range_inclusive: %s not in range [%s,%s]" % [value, minV, maxV],
		message
	)
# Checks if minV < value < maxV
static func in_range_exclusive(
	value,
	minV,
	maxV,
	message:String = ""
) -> bool:
	return _do_assert(
		minV < value && value < maxV,
		"in_range_exclusive: %s not in range (%s,%s)" % [value, minV, maxV],
		message
	)
# Checks if value == other
static func equals(value,other,message:String = "")->bool:
	return _do_assert(
		value == other,
		"equals: %s should equal %s" % [value, other],
		message
	)

static func not_equals(value, other, message:String ="")->bool:
	return _do_assert(
		value != other,
		"not_equals: %s should not equal %s" % [value, other],
		message
	)
