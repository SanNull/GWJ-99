@tool
class_name LoseArmor
extends Effect

@export var char_deflator : float = .5

func apply(character: Character, skills: Array[Skill] = []):
	character.defense *= char_deflator

func remove(character: Character, skills: Array[Skill] = []):
	character.defense /= char_deflator

func filter_skill(skill: Skill):
	return skill is MultiplierSkill

	
