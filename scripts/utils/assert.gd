extends RefCounted
class_name Assert

const ASSERT_FAILED_MESSAGE = "ASSERTION FAILED: "

static func _do_assert(condition:bool, error: String, message:String) -> bool:
	assert(condition, "%s %s %s" % [ASSERT_FAILED_MESSAGE,error, message])
	return condition

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
