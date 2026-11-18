@tool
class_name GainHealth
extends Effect

@export var hp_percent := .35

func apply(character: Character, skills: Array[Skill] = []):
	var hp_to_gain = character.hp * hp_percent
	# if skill
	character.hp = minf(character.hp + hp_to_gain, character.max_hp)
