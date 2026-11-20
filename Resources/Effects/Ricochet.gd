class_name Ricochet
extends BaseDamage

@export var chance := .45

func apply(character: Character, skills: Array[Skill] = []):
	character.hp -= absf(dmg - character.defense)

func who_to_apply(yourself, other):
	if randf_range(0, 1.0) < .45:
		return yourself
	return other

func _init() -> void:
	dmg = 25.0

func remove(character: Character, skills: Array[Skill] = []):
	return
