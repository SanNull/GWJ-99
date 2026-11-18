@tool
class_name MultipliedDamage
extends Effect

@export var dmg := 10.0
@export var multiplier := 2.0

func apply(character: Character, skills: Array[Skill] = []):
	var dealt_dmg = dmg * multiplier
	for skill in skills:
		if skill is MultiplierSkill:
			dealt_dmg *= skill.multiplier
	character.hp -= absf(dealt_dmg - character.defense) 

func filter_skill(skill: Skill):
	return skill is MultiplierSkill
