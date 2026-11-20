@tool
class_name Stun
extends Effect

@export var chance := .25

func apply(character: Character, skills: Array[Skill] = []):
	if randf_range(.0,1.0) < chance:
		character.is_stunned = true

func remove(character: Character, skills: Array[Skill] = []):
	character.is_stunned = false

func _init() -> void:
	need_removal = true
	
