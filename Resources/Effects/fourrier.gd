@tool
class_name Fourrier
extends BaseDamage

func apply(character: Character, skills: Array[Skill] = []):
	if randf_range(0.0, 1.0) <= .45:
		return
	var dealt_dmg = dmg
	for skill in skills:
		if skill is MultiplierSkill:
			dealt_dmg *= skill.multiplier
	character.hp -= absf(dealt_dmg - character.defense) 

func filter_skill(skill: Skill):
	return skill is MultiplierSkill
