@tool
class_name BaseDefense
extends Effect

@export var defense := 10

func apply(character: Character, skill: Skill = null):
	character.defense += defense #TODO its permanent

func filter_skill(skill: Skill):
	return skill is MultiplierSkill

func _init() -> void:
	apply_on_self = true
