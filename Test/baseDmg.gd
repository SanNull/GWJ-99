class_name BaseDamage
extends Effect

@export var dmg := 10

func apply(character: Character, skill: Skill = null):
	var dealt_dmg = dmg - 2 * int(character.current_emotion == character.EMOTIONS.HEARTSTRIKEN)
	if skill is MultiplierSkill:
		dealt_dmg *= skill.multiplier
	character.hp -= absf(dealt_dmg - character.defense) 

func filter_skill(skill: Skill):
	return skill is MultiplierSkill
