extends RefCounted
class_name CreatureData

## This creature's name that they will be referred to by
var nickname: String

## Gender settings
var pronoun: String # he/she/they
var pronoun_objective: String # him/her/them
var pronun_possessive: String # his/her/their

# How does this creature present?
var gender: Enums.Gender

## Age settings
var birthday: DateTime

## Creature's full name
func get_full_name(_show_nickname: bool = true) -> String:
	return nickname

# Get the creatures age in years
func get_age(current_time: DateTime) -> int:
	return current_time.subtract(birthday).year
