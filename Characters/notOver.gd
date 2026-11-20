class_name NotOverEnemy
extends EnemyStats

var BASIC_DAMAGE :Card= preload("uid://viw1fgxo4xwo").duplicate(true)
var DEFENSE :Card= preload("uid://o3rdf4niawjo").duplicate(true)
var PIERCE_DMG :Card= preload("uid://46jvqnr1ifvl").duplicate(true)

var prevHp : float = hp

func pick_card() -> Card:
	var delta = absf(hp - prevHp)
	prevHp = hp
	if delta > 15.0:
		return DEFENSE
	else:
		if (randf_range(0,1.0)) < .25:
			return PIERCE_DMG
		return BASIC_DAMAGE
	#var chance := randf_range(0, 1)
	
func _init() -> void:
	BASIC_DAMAGE.effects[0].dmg = 30
