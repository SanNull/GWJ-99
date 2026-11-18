class_name RemoveHealth
extends Effect

@export var deflator := .25

func apply(character: Character, skills: Array[Skill] = []):
	character.hp *= deflator
