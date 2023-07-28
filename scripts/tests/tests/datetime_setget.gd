extends TestScript

# Should return the name of this test
func test_name():
	return "DateTime SetGet"

# Should return a description of this test
func test_description():
	return "Checking that the datetime setters and getters are correct"

# This should actually run the test
func run_test():
	for year in range(-1,1):
		var epoch_total := 0
		var season := 0
		var day := 0
		var hour := 0
		var minute := 0
		var datetime: DateTime = DateTime.new()
		
		expect_equals(datetime.year, 0, "New datetime has 0 year")
		expect_equals(datetime.season, 0, "New datetime has 0 season")
		expect_equals(datetime.day, 0, "New datetime has 0 day")
		expect_equals(datetime.hour, 0, "New datetime has 0 hour")
		expect_equals(datetime.minute, 0, "New datetime has 0 minute")
		expect_equals(datetime.since_epoch, 0, "New datetime has 0 since_epoch")
		datetime.year = year
		expect_equals(datetime.year, year, "year: Setting year to %s" % year)
		expect_equals(datetime.season, season, "year: Season should be %s" % season)
		expect_equals(datetime.day, day, "year: Day should be %s" % day)
		expect_equals(datetime.hour, hour, "year: Hour should be %s" % hour)
		expect_equals(datetime.minute, minute, "year: Minute should be %s" % minute)
		epoch_total += year*DateTime.MINUTES_PER_YEAR
		expect_equals(datetime.since_epoch, epoch_total, "year: since_epoch should be MINUTES_PER_YEAR")
		
		season = randi_range(0,DateTime.SEASONS_PER_YEAR-1)
		datetime.season = season
		expect_equals(datetime.season, season, "season: Setting season to %s" % season)
		expect_equals(datetime.year, year, "season: Year should be %s" % year)
		expect_equals(datetime.day, day,"season: Day should be %s" % day)
		expect_equals(datetime.hour, hour, "season: Hour should be %s" % hour)
		expect_equals(datetime.minute, minute, "season: Minute should be %s" % minute)
		epoch_total += season*DateTime.MINUTES_PER_SEASON
		expect_equals(datetime.since_epoch, epoch_total, "season: since_epoch is set correctly")
		
		day = randi_range(0,DateTime.DAYS_PER_SEASON-1)
		datetime.day = day
		expect_equals(datetime.day, day, "day: Setting day to %s" % day)
		expect_equals(datetime.year, year, "day: Year should be %s" % year)
		expect_equals(datetime.season, season, "day: Season should be %s" % season)
		expect_equals(datetime.hour, hour, "day: Hour should be %s" % hour)
		expect_equals(datetime.minute, minute, "day: Minute should be %s" % minute)
		epoch_total += day*DateTime.MINUTES_PER_DAY
		expect_equals(datetime.since_epoch, epoch_total, "day: since_epoch is set correctly")
		
		hour = randi_range(0, DateTime.HOURS_PER_DAY-1)
		datetime.hour = hour
		expect_equals(datetime.hour, hour, "hour: Setting hour to %s" % hour)
		expect_equals(datetime.year, year, "hour: Year should be %s" % year)
		expect_equals(datetime.season, season, "hour: Season should be %s" % season)
		expect_equals(datetime.day, day,"hour: Day should be %s" % day)
		expect_equals(datetime.minute, minute, "hour: Minute should be %s" % minute)
		epoch_total += hour*DateTime.MINUTES_PER_HOUR
		expect_equals(datetime.since_epoch, epoch_total, "hour: since_epoch is set correctly")
		
		minute = randi_range(0, DateTime.MINUTES_PER_HOUR-1)
		datetime.minute = minute
		expect_equals(datetime.minute, minute, "minute: Setting minute to %s" % minute)
		expect_equals(datetime.year, year, "minute: Year should be %s" % year)
		expect_equals(datetime.season, season, "minute: Season should be %s" % season)
		expect_equals(datetime.day, day,"minute: Day should be %s" % day)
		expect_equals(datetime.hour, hour, "minute: Hour should be %s" % hour)
		epoch_total += minute
		expect_equals(datetime.since_epoch, epoch_total, "minute: since_epoch is set correctly")

