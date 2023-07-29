extends CreatureData
class_name IslanderData

### Personal Details
## Name settings
var first_name: String
var last_name: String

# True -> Firstname 'Nickname' Lastname
# False -> Lastname 'Nickname' Firstname
var first_name_then_last_name: bool 

# Who will this islander try to date?
var attracted_to: Array[Enums.Gender]
# Can this islander get pregnant
var pregnancy_enabled: bool

### Appearance Settings
var skin_tone: Color
var hair_root_color: Color
var hair_tips_color: Color

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
