class_name TrinitySet
extends Resource

var target: Character
var selected_skills: Array[Skill]
var card: Card

func _init(t: Character, s: Array[Skill], c: Card) -> void:
	target = t
	selected_skills = s
	card = c
