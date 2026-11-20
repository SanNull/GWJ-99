class_name TrinitySet
extends Resource

var target: Character
var skills: Array[Skill]
var effect: Effect
var dealer: Character

func _init(t: Character, d: Character,  s: Array[Skill], e: Effect) -> void:
	target = t
	dealer = d
	skills = s
	effect = e

var done_for := false

func decrease_duration():
	effect.duration -= 1

func decrease_application():
	effect.aplications -= 1

func will_be_used_on_the_future():
	return effect.offset != 0

func is_done_for():
	return effect.duration <= 0 or dealer.is_stunned

##Returns true only if effect got applied
func apply_effect():
	if dealer.is_stunned:
		return false 
	if will_be_used_on_the_future():
		effect.offset -= 1
		return false
	if effect.aplications == 0:
		return false
	effect.apply(target, skills)
	decrease_application()
	decrease_duration()
	return true

func get_attack_description():
	return effect.descrpition

func clear_effect():
	effect.remove(target, skills)
