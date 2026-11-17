#class_name BattleManager
extends Node

signal turn_started
signal battle_ended(has_won: bool)

@onready var player : playerStats = load("")
var enemies : Array[EnemyStats]

var selected_card : Card
var selected_skills: Array[Skill]
var selected_enemy: Character

#Cards whose effects will last for turns or who will trigger on the next one
var queued_cards: Array[Card]
#Effects that need to be removed at the end of turn
var effects_for_removal: Dictionary[Effect, Character]

func on_turn_end():
	player.move_set.shuffle()
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
	battle_ended.emit(true)

func _handle_card_duration(card: Card, is_on_queue: bool = false):
	card.duration -= 1
	if is_on_queue:
		return
	if card.duration > 1 or card.start_on_next_turn:
		queued_cards.append(card)

func clear_selection():
	selected_card = null
	selected_enemy = null

func _clear_effects():
	for key in effects_for_removal:
		key.remove(effects_for_removal[key])

func _apply_player_effects():
	if selected_card == null: 
		return
	_handle_card_duration(selected_card, false)
	if selected_card.start_on_next_turn:
		return
	if selected_enemy == null:
		selected_enemy = enemies.pick_random()
	for eff in selected_card.effects:
		var c := player if eff.apply_on_self else selected_enemy
		var skill_filtered = selected_skills.filter(eff.filter_skill)
		eff.apply(c, null if not skill_filtered else skill_filtered[0]) #TODO
		if eff.need_removal:
			effects_for_removal[eff] = c

func _apply_enemy_effects(e: EnemyStats):
	var card: Card = e.pick_card()
	_handle_card_duration(card, false)
	if card.start_on_next_turn:
		return
	for eff in card.effects:
		var c : Character = e if eff.apply_on_self else player
		eff.apply(c)
		if eff.need_removal and card.duration < 1:
			effects_for_removal[eff] = c

func _apply_queued_cards():
	var remaining_cards: Array[Card] = []
	for c in queued_cards:
		c.duration -= 1
		if c.duration > 1:
			remaining_cards.append(c)
		for eff in c.effects:
			var target = player #TODO
			var skill_filtered = selected_skills.filter(eff.filter_skill)
			eff.apply(target, null if not skill_filtered else skill_filtered[0]) #TODO
	queued_cards = remaining_cards

func _ready() -> void:
	selected_card = player.move_set[0]
	turn_started.connect(clear_selection)
	turn_started.connect(_apply_queued_cards)

func toggle_skill_to_list(skill: Skill, skill_signal: Signal):
	if skill in selected_skills:
		player.points += skill.points_required
		selected_skills.erase(skill)
		skill_signal.emit(skill)
		return
	if player.points < skill.points_required:
		return
	selected_skills.append(skill)
	player.points -= skill.points_required
	skill_signal.emit(skill)

func select_card(card):
	selected_card = card

func select_enemy(enemy):
	selected_enemy = enemy
