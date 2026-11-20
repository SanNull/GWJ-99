class_name addSkill
extends Effect

@export var eff_skill : Skill

func apply(character: Character, skills: Array[Skill] = []):
	if character is playerStats:
		descrpition = descrpition % "Player"
		character.skills.append(eff_skill)
	else: descrpition = descrpition % "Enemy"

func remove(character: Character, skills: Array[Skill] = []):
	if character is playerStats:
		character.skills.erase(eff_skill)

func filter_skill(skill: Skill):
	return null

func _init() -> void:
	descrpition = "%s added skill"
