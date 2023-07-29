extends TestScript

# Should return the name of this test
func test_name() -> String:
	return "Floor to N test"

# Should return a description of this test
func test_description() -> String:
	return "Checks to see if the floor to n function returns the correct values"

# This should actually run the test
func run_test() -> void:
	var expected := [
		# floor to nearest 1
		-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0,
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
		# floor to nearest 2
		-10, -10, -8, -8, -6, -6, -4, -4, -2, -2, 0,
		0, 2, 2, 4, 4, 6, 6, 8, 8, 10,
		# floor to nearest 3
		-12, -9, -9, -9, -6, -6, -6, -3, -3 ,-3, 0,
		0, 0, 3, 3, 3, 6, 6, 6, 9, 9,
		# floor to nearest 4
		-12, -12, -8, -8, -8, -8, -4, -4, -4, -4,
		0, 0, 0, 0, 4, 4, 4, 4, 8, 8, 8
	]
	var index := 0
	for n in range(1,5): # Checking 1, 4
		for value in range(-10,11): # Checking -10, 10
			expect_equals(
				Maths.floor_to_n(value,n), 
				expected[index], 
				"Floor %s to nearest %s should be %s" % [value, n, expected[index]]
			)
			index += 1

