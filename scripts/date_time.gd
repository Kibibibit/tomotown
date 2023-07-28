extends RefCounted
class_name DateTime

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
	

var since_epoch: int




func _get_year() -> int:
	return 0

func _set_year(_year: int) -> void:
	pass
	
func _get_season() -> int:
	return 0

func _set_season(_season:int) -> void:
	pass

func _get_day() -> int:
	return 0

func _set_day(_day: int) -> void:
	pass
