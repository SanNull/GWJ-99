@tool
@abstract class_name Effect extends Resource

@export var apply_on_self: bool = false
@export var need_removal: bool = false

@export var aplications := 1
@export var duration := 1
@export var start_on_next_turn := false
@export var descrpition: String = ""

@abstract func apply(character: Character, skills: Array[Skill] = [])

func filter_skill(skill: Skill):
	return null

@abstract func remove(character: Character, skills: Array[Skill] = [])

func who_to_apply(yourself, other):
	return yourself if apply_on_self else other

func get_description():
	return descrpition
