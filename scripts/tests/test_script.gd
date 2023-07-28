extends RefCounted
class_name TestScript

const TEST_PASSED := "✓"
const TEST_FAILED := "X"

var passed := 0
var ran := 0

func run_check(actual, expected, operator, check, message) -> bool:
	ran += 1
	if (TestRunner.VERBOSE_TESTS):
		var c = TEST_PASSED
		if (!check):
			c = TEST_FAILED
		print("\t%s\t%s %s %s\t %s" % [c,actual, operator, expected, message])
	if (check):
		passed += 1
	return check

func expect_equals(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "==", actual == expected, message)

func do_run_test():
	run_test()
	return ran == passed

func test_name() -> String:
	push_error("Don't use test script directly! Extend it!")
	return ""

func test_description() -> String:
	push_error("Don't use test script directly! Extend it!")
	return ""

func run_test() -> bool:
	push_error("Don't use test script directly! Extend it!")
	return false
