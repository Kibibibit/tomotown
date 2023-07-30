extends RefCounted
class_name DateTime

# Represents a datetime, stored as a time since epoch (year 0).
# Dates have year, season (month), day, hour, minute

## The amount of minutes in an hour
const MINUTES_PER_HOUR: int = 60
## The amount of hours in a day
const HOURS_PER_DAY: int = 24
## The amount of days in a season
const DAYS_PER_SEASON: int = 30
## The amount of seasons in a year
const SEASONS_PER_YEAR: int = 4

const MINUTES_PER_DAY: int = HOURS_PER_DAY*MINUTES_PER_HOUR
const MINUTES_PER_SEASON: int = DAYS_PER_SEASON*MINUTES_PER_DAY
const MINUTES_PER_YEAR: int = SEASONS_PER_YEAR*MINUTES_PER_SEASON

const SPRING = 0
const SUMMER = 1
const AUTUMN = 2
const WINTER = 3

### VIRTUAL PROPERTIES (SETTERS AND GETTERS)

## The current year. Can go negative
var year : int :
	get:
		return _get_year()
	set(_year):
		_set_year(_year)

## The current season. Must be 0-3
var season : int :
	get:
		return _get_season()
	set(_season):
		_set_season(_season)

## The current day. Must be 0-29
var day : int : 
	get:
		return _get_day()
	set(_day):
		_set_day(_day)
	
var hour : int :
	get:
		return _get_hour()
	set(_hour):
		_set_hour(_hour)

var minute : int :
	get :
		return _get_minute()
	set(_minute):
		_set_minute(_minute)



### PROPERTIES

## This the the amount of minutes since year 0
var since_epoch: int

## CONSTRUCTORS/FACTORYISH METHODS
func _init(_year: int = 0, _season: int = 0, _day:int = 0, _hour:int = 0, _minute: int = 0):
	since_epoch = _calculate_epoch(_year,_season,_day,_hour,_minute)

## Also a constructor kind of?
static func from_epoch(epoch: int) -> DateTime:
	var out := DateTime.new()
	out.since_epoch = epoch
	return out

static func years(_years:int) -> DateTime:
	return DateTime.from_epoch(_years*MINUTES_PER_YEAR)

static func seasons(_seasons: int) -> DateTime:
	return DateTime.from_epoch(_seasons*MINUTES_PER_SEASON)

static func days(_days: int) -> DateTime:
	return DateTime.from_epoch(_days*MINUTES_PER_DAY)

static func hours(_hours:int) -> DateTime:
	return DateTime.from_epoch(_hours*MINUTES_PER_HOUR)

static func minutes(_minutes:int) -> DateTime:
	return DateTime.from_epoch(_minutes)



func year_epoch() -> int:
	return _unit_epoch(MINUTES_PER_YEAR)

func season_epoch() -> int:
	return _unit_epoch(MINUTES_PER_SEASON)

func day_epoch() -> int:
	return _unit_epoch(MINUTES_PER_DAY)

func hour_epoch() -> int:
	return _unit_epoch(MINUTES_PER_HOUR)



func add(other: DateTime) -> DateTime:
	return DateTime.from_epoch(since_epoch+other.since_epoch)

func subtract(other: DateTime) -> DateTime:
	return DateTime.from_epoch(since_epoch-other.since_epoch)

func add_years(_years:int) -> DateTime:
	return _add_units(_years, MINUTES_PER_YEAR)
	
func subtract_years(_years:int) -> DateTime:
	return add_years(-_years)

func add_seasons(_seasons:int) -> DateTime:
	return _add_units(_seasons, MINUTES_PER_SEASON)

func subtract_seasons(_seasons:int) -> DateTime:
	return add_seasons(-_seasons)

func add_days(_days:int) -> DateTime:
	return _add_units(_days, MINUTES_PER_DAY)

func subtract_days(_days:int) -> DateTime:
	return add_days(-_days)

func add_hours(_hours:int) -> DateTime:
	return _add_units(_hours, MINUTES_PER_HOUR)

func subtract_hours(_hours:int) -> DateTime:
	return add_hours(-_hours)

func add_minutes(_minutes:int) -> DateTime:
	return DateTime.from_epoch(since_epoch+_minutes)

func subtract_minutes(_minutes:int) -> DateTime:
	return add_minutes(-_minutes)




func is_after(other: DateTime) -> bool:
	return since_epoch > other.since_epoch

func is_before(other: DateTime) -> bool:
	return since_epoch < other.since_epoch

func equals(other: DateTime) -> bool:
	return since_epoch == other.since_epoch

func same_year(other:DateTime) -> bool:
	return year_epoch() == other.year_epoch()

func same_season(other:DateTime) -> bool:
	return season_epoch() == other.season_epoch()

func same_day(other:DateTime) -> bool:
	return day_epoch() == other.day_epoch()

func same_hour(other:DateTime) -> bool:
	return hour_epoch() == other.hour_epoch()

func same_minute(other:DateTime) -> bool:
	return equals(other)



# Calculate the time since epoch based on the times
func _calculate_epoch(_year:int, _season:int, _day:int, _hour:int, _minute:int) -> int:
	return (
		MINUTES_PER_YEAR*_year +
		MINUTES_PER_SEASON*_season +
		MINUTES_PER_DAY*_day +
		MINUTES_PER_HOUR*_hour +
		_minute
	)

func _to_string() -> String:
	return "%4d-%d-%2d@%2d:%2d" % [year, season+1, day+1, hour+1, minute+1] 

func _add_units(amount:int, mpx:int)->DateTime:
	return DateTime.from_epoch(since_epoch+(amount*mpx))

func _unit_epoch(mpx: int)->int:
	return Maths.floor_to_n(since_epoch, mpx)

func _get_year() -> int:
	return floori(since_epoch / float(MINUTES_PER_YEAR))

func _set_year(_year: int) -> void:
	since_epoch = _calculate_epoch(_year,season,day,hour,minute)

func _get_season() -> int:
	return _calculate_minutes(MINUTES_PER_SEASON, SEASONS_PER_YEAR)

func _set_season(_season:int) -> void:
	Assert.in_range(_season, 0, SEASONS_PER_YEAR, "Bad Season %s" % [_season])
	since_epoch = _calculate_epoch(year,_season,day,hour,minute)

func _get_day() -> int:
	return _calculate_minutes(MINUTES_PER_DAY, DAYS_PER_SEASON)

func _set_day(_day: int) -> void:
	Assert.in_range(_day, 0, DAYS_PER_SEASON, "Bad Day %s" % [_day])
	since_epoch = _calculate_epoch(year,season,_day,hour,minute)

func _get_hour() -> int:
	return _calculate_minutes(MINUTES_PER_HOUR, HOURS_PER_DAY)

func _set_hour(_hour: int) -> void:
	Assert.in_range(_hour, 0, HOURS_PER_DAY, "Bad Hour %s" % [_hour])
	since_epoch = _calculate_epoch(year,season,day,_hour,minute)

func _get_minute() -> int:
	return _calculate_minutes(1, MINUTES_PER_HOUR)

func _set_minute(_minute: int) -> void:
	Assert.in_range(_minute, 0, MINUTES_PER_HOUR, "Bad Minute %s" % [_minute])
	since_epoch = _calculate_epoch(year,season,day,hour,_minute)

# Calculates the amount of time unit X from the epoch.
# mpx -> Minutes per unit X
# xpy -> Unit X per Unit Y, where Y is one level up from X.
#		 So for X = Hour, Y = Day or X = Season, Y = Year
func _calculate_minutes(mpx: int, xpy: int) -> int:
	return posmod(floori(since_epoch/float(mpx)), xpy)
