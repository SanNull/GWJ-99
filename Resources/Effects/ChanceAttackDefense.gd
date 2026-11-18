class_name ChanceAttackDefense
extends BaseDamage

@export var def := 3.0
@export var chance := .05
var applied := false

func apply(character: Character, skills: Array[Skill] = []):
	if applied:
		super(character, skills)
		return
	character.defense += def

func who_to_apply(yourself, other):
	if randf_range(0,1) <= chance:
		applied = true
		return other
	return yourself
