extends CreatureData
class_name IslanderData

### Personal Details

## This islander's first name
var first_name: String
## This islander's last name
var last_name: String

## Does this islander arrange their name with their first name first?
var first_name_then_last_name: bool 

## Islanders will be attracted to genders in this array
var attracted_to: Array[Enums.Gender]
## Can this islander get pregnant?
var pregnancy_enabled: bool

### Appearance Settings

## The islander's skin tone
var skin_tone: Color
## The color of the islander's hair roots
var hair_root_color: Color
## The color of the islander's hair tips
var hair_tips_color: Color
## The islander's favourite color
var favourite_color: Color


# Returns the full name for this Islander
# Overrides parent
func get_full_name(show_nickname: bool = false) -> String:
	var nick: String = ""
	if (show_nickname):
		nick = "'%s'" % nickname
	var front = first_name
	var back = last_name
	if (!first_name_then_last_name):
		back = first_name
		front =  last_name
	return "%s %s %s" % [front, nick, back]

func is_attracted_to_gender(_gender: Enums.Gender) -> bool:
	return attracted_to.has(_gender)

func romantically_compatible(other: IslanderData) -> bool:
	return is_attracted_to_gender(other.gender) && other.is_attracted_to_gender(gender)
