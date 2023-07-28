extends RefCounted
class_name DateTime

const MINUTES_PER_HOUR: int = 60
const HOURS_PER_DAY: int = 24
const DAYS_PER_SEASON: int = 30
const SEASONS_PER_YEAR: int = 4

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

var since_epoch: int




func _get_year() -> int:
	return floor(since_epoch / float(MINUTES_PER_HOUR*HOURS_PER_DAY*DAYS_PER_SEASON*SEASONS_PER_YEAR))

func _set_year(_year: int) -> void:
	pass
	
func _get_season() -> int:
	return floor(since_epoch / float(MINUTES_PER_HOUR*HOURS_PER_DAY*DAYS_PER_SEASON)) % SEASONS_PER_YEAR

func _set_season(_season:int) -> void:
	pass

func _get_day() -> int:
	return floor(since_epoch / float(MINUTES_PER_HOUR*HOURS_PER_DAY)) % DAYS_PER_SEASON

func _set_day(_day: int) -> void:
	pass

func _get_hour() -> int:
	return floor(since_epoch / float(MINUTES_PER_HOUR)) % HOURS_PER_DAY

func _set_hour(_hour: int) -> void:
	pass

func _get_minute() -> int:
	return since_epoch % MINUTES_PER_HOUR

func _set_minute(_minute: int) -> void:
	pass
