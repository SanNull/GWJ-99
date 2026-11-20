class_name NotOverEnemy
extends EnemyStats

const BASIC_DAMAGE = preload("uid://viw1fgxo4xwo")
const DEFENSE = preload("uid://o3rdf4niawjo")
const PIERCE_DMG = preload("uid://46jvqnr1ifvl")

func pick_card() -> Card:
	#More cautious on attacks, prioritizes normal attacks and self defense
	var chance := randf_range(0, 1)
	if hp > 50.0:
		if chance < .55:
			var base_dmg := BASIC_DAMAGE.duplicate(true)
			base_dmg.effects[0].dmg = 20
			return base_dmg
		var d = DEFENSE.duplicate()
		d.effects[0].duration = 1
		return d
	else:
		if chance < .75:
			var base_dmg := BASIC_DAMAGE.duplicate()
			base_dmg.effects[0].dmg = 20
			return base_dmg
		return PIERCE_DMG
