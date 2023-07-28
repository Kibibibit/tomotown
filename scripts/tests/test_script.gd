extends RefCounted
class_name TestScript

const TEST_PASSED := "✓"
const TEST_FAILED := "X"

var verbose: bool = false
var passed := 0
var ran := 0
var printout := ""

func run_check(actual, expected, operator, check, message) -> bool:
	ran += 1
	var c = TEST_PASSED
	if (!check):
		c = TEST_FAILED
	else:
		passed += 1
	if (verbose || !check):
		printout = "%s\n\t%s %s\n\t\t%s %s %s" % [printout,c,message,actual,operator,expected]
	return check

func expect_equals(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "==", actual == expected, message)

func do_run_test():
	run_test()
	var test_passed = ran == passed
	var c = "%s PASSED:" % TEST_PASSED
	if (!test_passed):
		c = "%s FAILED:" % TEST_FAILED
	print("%s %s" % [c,test_name()])
	print(test_description())
	print("%s/%s Checks passed" % [passed,ran])
	print(printout)
	return ran == passed

func test_name() -> String:
	push_error("Don't use test script directly! Extend it!")
	return ""

func test_description() -> String:
	push_error("Don't use test script directly! Extend it!")
	return ""

func run_test() -> void :
	push_error("Don't use test script directly! Extend it!")
