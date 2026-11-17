class_name BattleManager
extends Node

signal turn_started
signal battle_ended(has_won: bool)

@onready var player : playerStats = load("res://Test/PlayerStats.tres")
var enemies : Array[Character]

var selected_card : Card
var selected_skills: Array[Skill]
var selected_enemy: Character

func on_turn_end():
	for e in enemies:
		_apply_enemy_effects(e)
	player.debug_print()
	if player.hp <= 0.0: 
		battle_ended.emit(false)
		return
	_apply_player_effects()
	for e in enemies: 
		e.debug_print("enemy")
		if e.hp > 0: 
			turn_started.emit()
			return
	for e in enemies: 
		if e.hp > 0: 
			turn_started.emit()
			return
	battle_ended.emit(true)

func clear_selection():
	selected_card = null
	selected_enemy = null

func _apply_player_effects():
	if selected_card == null: 
		return
	if selected_enemy == null:
		selected_enemy = enemies.pick_random()
	for eff in selected_card.effects:
		var c := player if eff.apply_on_self else selected_enemy
		var skill_filtered = selected_skills.filter(eff.filter_skill)
		eff.apply(c, null if not skill_filtered else skill_filtered[0]) #TODO

func _apply_enemy_effects(e: Character):
	for eff in e.move_set[0].effects:
		var c := e if eff.apply_on_self else player
		eff.apply(c)

func _ready() -> void:
	selected_card = player.move_set[0]
	turn_started.connect(clear_selection)

func _add_skill_to_list(skill: Skill):
	if player.points < skill.points_required:
		return
	selected_skills.append(skill)
	player.points -= skill.points_required
