@tool
class_name ChanceEffect extends Effect

@export var chance : float = .0
@export var eff_if_true: Effect
@export var eff_if_false : Effect
var chosen_eff: Effect
func apply(character: Character, skills: Array[Skill] = []):
	chosen_eff = eff_if_true if randf_range(.0,1.0) < chance else eff_if_false
	chosen_eff.apply(character,skills)

func remove(character: Character, skills: Array[Skill] = []):
	chosen_eff.remove(character,skills)

func _init() -> void:
	need_removal = true
