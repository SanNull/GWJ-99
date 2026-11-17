class_name EnemyStats
extends Character

func pick_card() -> Card:
	return move_set.pick_random()
