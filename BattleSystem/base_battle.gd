extends Control

@export var enemy_set: EnemySet
@onready var battle_control: BattleControl = $BattleControl

func _ready() -> void:
	battle_control.start_battle(enemy_set.enemy_set)
