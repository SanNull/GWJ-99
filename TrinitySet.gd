class_name TrinitySet
extends Resource

var target: Character
var skills: Array[Skill]
var effect: Effect

func _init(t: Character, s: Array[Skill], e: Effect) -> void:
	target = t
	skills = s
	effect = e

var done_for := false

func decrease_duration():
	effect.duration -= 1

func decrease_application():
	effect.aplications -= 1

func will_be_used_on_next_turn():
	return effect.start_on_next_turn

func is_done_for():
	return effect.duration <= 0

func apply_effect():
	if will_be_used_on_next_turn():
		effect.start_on_next_turn = false
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
