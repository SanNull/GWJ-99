@abstract class_name Effect extends Resource

@export var apply_on_self: bool = false
@abstract func apply(character: Character, skill: Skill = null)
func filter_skill(skill: Skill):
	return null
