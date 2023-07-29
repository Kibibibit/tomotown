extends RefCounted
class_name TestRunner

# Runs all of the test files in TEST_PATH

static var TEST_PATH: String

# Runs all tests. If verbose is true, all 
# checks will be printed, otherwise only failed checks will be
static func run_tests(verbose: bool):
	
	# Maps test name to test passed/failed state
	var tests: Dictionary = {}
	# How many tests failed
	var failed := 0
	# How many tests passed
	var passed := 0
	
	# Open the test folder
	var test_directory = DirAccess.open(TEST_PATH)
	test_directory.list_dir_begin()
	var filename: String = test_directory.get_next()
	# We get an empty string from get_next if we've run out of files
	while !filename.is_empty():
		# We only want gd files
		if (filename.ends_with(".gd")):
			# Load in the test script, and make sure it is actually a test
			var test = load("%s/%s" % [TEST_PATH, filename]).new()
			if (test is TestScript):
				# Set the verbose flag
				test.verbose = verbose
				# And then run the test
				var test_name = test.test_name()
				var test_passed = test.do_run_test()
				tests[test_name] = test_passed
				if (test_passed):
					passed += 1
				else:
					failed += 1
		filename = test_directory.get_next()
	test_directory.list_dir_end()
	
	# Print out any tests that failed
	if (failed > 0):
		print("\nFAILS:")
	for name in tests.keys():
		if !tests[name]:
			print("\tFAILED: %s" % name)
	# Print the final results
	print("\nTALLY:")
	print("\tPASSED: %s" % passed)
	print("\tFAILED: %s\n\n" % failed)
