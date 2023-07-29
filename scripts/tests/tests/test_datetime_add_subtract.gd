extends TestScript

# Should return the name of this test
func test_name() -> String:
	return "DateTime AddSubtract"

# Should return a description of this test
func test_description() -> String:
	return "Checking the addition and subtraction datetime methods"

# This could use some more tests
# This should actually run the test
func run_test() -> void:
	var date := DateTime.new(5,DateTime.AUTUMN,15,12,30)
	
	date = date.add(DateTime.hours(5))
	expect_equals(date.hour, 17, "Adding 5 hours")
	expect_equals(date.year, 5, "Year should not have changed")
	expect_equals(date.season, DateTime.AUTUMN, "Season should not have changed")
	expect_equals(date.day, 15, "Day should not have changed")
	expect_equals(date.minute, 30, "Minute should not have changed")
	
	date = date.add(DateTime.hours(7))
	expect_equals(date.hour, 0, "Adding another 7 hours, should roll over")
	expect_equals(date.year, 5, "Year should not have changed")
	expect_equals(date.season, DateTime.AUTUMN, "Season should not have changed")
	expect_equals(date.day, 16, "Day should have rolled over")
	expect_equals(date.minute, 30, "Minute should not have changed")
	
	date = date.add(DateTime.new(0,0,13,23,29))
	expect_equals(date.year, 5, "Adding time up until about to roll over season")
	expect_equals(date.season, DateTime.AUTUMN, "Season should not have changed")
	expect_equals(date.day, 29, "Day should be on the 29th")
	expect_equals(date.hour, 23, "Hour should be 11PM")
	expect_equals(date.minute, 59, "Minutes should 1 minute to midnight")
	
	date = date.add(DateTime.minutes(1))
	expect_equals(date.minute, 0, "Added one minute")
	expect_equals(date.year, 5, "Year should not have changed")
	expect_equals(date.season, DateTime.WINTER, "Season should have rolled over")
	expect_equals(date.day, 0, "Day should have rolled over")
	expect_equals(date.hour, 0, "Hour should have rolled over")
	
	date = date.subtract(DateTime.hours(1))
	expect_equals(date.hour, 23, "Subtracting one hour")
	expect_equals(date.year, 5, "Year should not have changed")
	expect_equals(date.season, DateTime.AUTUMN, "Season should have rolled back")
	expect_equals(date.day, 29, "Day should have rolled back")
	expect_equals(date.minute, 0, "Minute should not have changed")
