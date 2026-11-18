@tool
class_name BaseDefense
extends Effect

@export var defense := 10

func apply(character: Character, skills: Array[Skill] = []):
	character.defense += defense #TODO its permanent

func remove(character: Character, skills: Array[Skill] = []):
	character.defense -= defense

func filter_skill(skill: Skill):
	return skill is MultiplierSkill

	
