@abstract class_name Effect extends Resource

@export var apply_on_self: bool = false
@export var need_removal: bool = false

@abstract func apply(character: Character, skill: Skill = null)

func filter_skill(skill: Skill):
	return null

func remove(character: Character, skill: Skill = null):
	return 
