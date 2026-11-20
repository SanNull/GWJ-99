@tool
class_name PierceDamage
extends Effect

@export var dmg := 5

func apply(character: Character, skills: Array[Skill] = []):
	character.hp -= dmg

func filter_skill(skill: Skill):
	return skill is MultiplierSkill

func remove(character: Character, skills: Array[Skill] = []):
	return
