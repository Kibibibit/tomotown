extends RefCounted
class_name DateTime

# Represents a datetime, stored as a time since epoch (year 0).
# Dates have year, season (month), day, hour, minute

const MINUTES_PER_HOUR: int = 60
const HOURS_PER_DAY: int = 24
const DAYS_PER_SEASON: int = 30
const SEASONS_PER_YEAR: int = 4

const MINUTES_PER_DAY: int = HOURS_PER_DAY*MINUTES_PER_HOUR
const MINUTES_PER_SEASON: int = DAYS_PER_SEASON*MINUTES_PER_DAY
const MINUTES_PER_YEAR: int = SEASONS_PER_YEAR*MINUTES_PER_SEASON


const SUMMER = 0
const AUTUMN = 1
const WINTER = 2
const SPRING = 3

var year : int :
	get:
		return _get_year()
	set(_year):
		_set_year(_year)

var season : int :
	get:
		return _get_season()
	set(_season):
		_set_season(_season)

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

## This the the amount of minute since year 0
var since_epoch: int

## Constructor
func _init(_year: int = 0, _season: int = 0, _day:int = 0, _hour:int = 0, _minute: int = 0):
	since_epoch = _calculate_epoch(_year,_season,_day,_hour,_minute)

# Calculate the time since epoch based on the times
func _calculate_epoch(_year:int, _season:int, _day:int, _hour:int, _minute:int) -> int:
	return (
		MINUTES_PER_YEAR*_year +
		MINUTES_PER_SEASON*_season +
		MINUTES_PER_DAY*_day +
		MINUTES_PER_HOUR*_hour +
		_minute
	)

## Also a constructor kind of?
static func from_epoch(epoch: int) -> DateTime:
	var out := DateTime.new()
	out.since_epoch = epoch
	return out

func add(other: DateTime) -> DateTime:
	return DateTime.from_epoch(since_epoch+other.since_epoch)
func subtract(other: DateTime) -> DateTime:
	return DateTime.from_epoch(since_epoch-other.since_epoch)

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
