extends RefCounted
class_name TestRunner

const TEST_PATH = "res://scripts/tests/tests"

static func run_tests(verbose: bool):
	
	var tests: Dictionary = {}
	var failed := 0
	var passed := 0
	
	var test_directory = DirAccess.open(TEST_PATH)
	test_directory.list_dir_begin()
	var filename: String = test_directory.get_next()
	while !filename.is_empty():
		if (filename.ends_with(".gd")):
			var test: Object = load("%s/%s" % [TEST_PATH, filename]).new()
			if (test is TestScript):
				test.verbose = verbose
				var test_name = test.test_name()
				var test_passed = test.do_run_test()
				tests[test_name] = test_passed
				if (test_passed):
					passed += 1
				else:
					failed += 1
		filename = test_directory.get_next()
	test_directory.list_dir_end()
	
	if (failed > 0):
		print("\nFAILS:")
	for name in tests.keys():
		if !tests[name]:
			print("\tFAILED: %s" % name)
	print("\nTALLY:")
	print("\tPASSED: %s" % passed)
	print("\tFAILED: %s\n\n" % failed)
