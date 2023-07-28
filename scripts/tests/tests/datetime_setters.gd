extends TestScript

# Should return the name of this test
func test_name():
	return "DateTime setters"

# Should return a description of this test
func test_description():
	return "Checking that the datetime setters are correct"

# This should actually run the test
func run_test():
	var datetime: DateTime = DateTime.new()
	expect_equals(datetime.year, 0, "New datetime has 0 year")
	datetime.year = 1
	expect_equals(datetime.year, 1, "Setting year to 1 results in get year 1")
	expect_equals(datetime.season, 0, "Setting year to 1 results in get season 0")
	expect_equals(datetime.day, 0, "Setting year to 1 results in get day 0")
	expect_equals(datetime.hour, 0, "Setting year to 1 results in get hour 0")
	expect_equals(datetime.minute, 0, "Setting year to 1 results in get minute 0")
