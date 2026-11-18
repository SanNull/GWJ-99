@tool
class_name ChanceLoseArmor extends LoseArmor

@export var chance := .65

func apply(character: Character, skills: Array[Skill] = []):
	if randf_range(.0, 1.0) <= chance:
		super(character,skills)

func remove(character: Character, skills: Array[Skill] = []):
	character.defense *= char_deflator

func filter_skill(skill: Skill):
	return skill is MultiplierSkill

	
