extends TestScript

# Should return the name of this test
func test_name() -> String:
	return "DateTime AddSubtract"

# Should return a description of this test
func test_description() -> String:
	return "Checking the addition and subtraction datetime methods"

# This should actually run the test
func run_test() -> void:
	var dateA := DateTime.new(5,DateTime.AUTUMN,15,12,30)
	
	var dateB := dateA.add(DateTime.hours(5))
	expect_equals(dateB.hour, 17, "Adding 5 hours")
	expect_equals(dateB.year, 5, "Year should not have changed")
	expect_equals(dateB.season, DateTime.AUTUMN, "Season should not have changed")
	expect_equals(dateB.day, 15, "Day should not have changed")
	expect_equals(dateB.minute, 30, "Minute should not have changed")
	
	dateA = dateB.add(DateTime.hours(7))
	expect_equals(dateA.hour, 0, "Adding another 7 hours, should roll over")
	expect_equals(dateA.year, 5, "Year should not have changed")
	expect_equals(dateA.season, DateTime.AUTUMN, "Season should not have changed")
	expect_equals(dateA.day, 16, "Day should have rolled over")
	expect_equals(dateA.minute, 30, "Minute should not have changed")
	
	
	
	

