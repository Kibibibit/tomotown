extends RefCounted
class_name TestScript

# This is the parent class for all test scripts.
# You can make a new one by selecting the template for it
# from the create script screen.

const TEST_PASSED := "✓"
const TEST_FAILED := "X"

var verbose: bool = false
# How many checks passed
var passed := 0
# How many checks failed
var ran := 0
# The output after the test
var printout := ""

# Displays and returns a boolean value `check`. All other parameters
# are for output at the end
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

# Check if actual is equal to expected
func expect_equals(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "==", actual == expected, message)

# Check if actual is not equal to expected
func expect_not_equals(actual, expected, message:String = "")->bool:
	return run_check(actual, expected,  "!=", actual != expected, message)

# Check if actual is greater than expected
func expect_greater(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "> ", actual > expected, message)

# Check if actual is greater than or equal to expected
func expect_greater_or_equal(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, ">=", actual >= expected, message)

# Check if actual is less than expected
func expect_less(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "< ", actual < expected, message)

# Check if actual is less than or equal to expected
func expect_less_or_equal(actual, expected, message:String = "")->bool:
	return run_check(actual, expected, "<=", actual >= expected, message)


# This script actually runs the test, run_test just contains the logic
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
