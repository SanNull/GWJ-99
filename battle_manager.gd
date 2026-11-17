class_name BattleManager extends Node

signal turn_ended
signal battle_ended(has_won: bool)

@export var player: playerStats
@export var enemies: Array[EnemyStats]

var selected_card: Card
var selected_skills: Array[Skill]
var selected_enemy : EnemyStats

var queued_cards: Array[TrinitySet]
var queued_effects: Array[Callable]

func _on_turn_start():
	_apply_queued_cards() #WARNING it updates before UI reaches signal
	_clear_effects()
	clear_selection()

func process_turn():
	for e in enemies:
		_use_card(e.pick_card(), e)
	if player.hp <= 0.0: 
		battle_ended.emit(false)
		return
	_use_card(selected_card, player)
	var remaining = len(enemies.filter(func(e: EnemyStats):  return e.hp > 0.0))
	if remaining == 0:
		battle_ended.emit(true)
		return
	turn_ended.emit()

func clear_selection():
	selected_card = null
	selected_enemy = null

func select_card(card):
	selected_card = card

func select_enemy(enemy):
	selected_enemy = enemy


func _use_card(c: Card, dealer: Character):
	if dealer is playerStats:
		if not _check_player_choices():
			return
	if not _handle_card_duration(c, dealer):
		if c.start_on_next_turn:
			return
	if dealer is playerStats:
		_apply_player_card(c, selected_enemy)
		return
	_apply_enemy_card(c, dealer)

func _apply_queued_cards():
	var remaining_cards: Array[TrinitySet]
	for t in queued_cards:
		if t.target is playerStats:
			_apply_enemy_card(t.card, null)
		else:
			_apply_player_card(t.card, t.target)
		t.card.duration -= 1
		if t.card.duration > 1:
			remaining_cards.append(t)
	queued_cards = remaining_cards

func _apply_player_card(c: Card, enemy: Character):
	for eff in c.effects:
		var skill = selected_skills.filter(eff.filter_skill)
		var target = player if eff.apply_on_self else enemy
		eff.apply(target, null if not skill else skill[0])
		if eff.need_removal:
			queued_effects.append(eff.remove.bind(target,null if not skill else skill[0]))

func _apply_enemy_card(c: Card, dealer: EnemyStats):
	for eff in c.effects:
		var target = dealer if eff.apply_on_self else player
		eff.apply(target)
		if eff.need_removal:
			queued_effects.append(eff.remove.bind(target))

func _clear_effects():
	for c in queued_effects:
		c.call()
	queued_effects = []

func _handle_card_duration(c: Card, dealer: Character):
	c.duration -= 1
	if c.duration >= 1 or c.start_on_next_turn:
		queued_cards.append(
			TrinitySet.new(
				player if dealer is EnemyStats else selected_enemy,
				selected_skills,c)
				)
		return false
	return true

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

func _check_player_choices():
	if selected_card == null:
		return false
	if selected_enemy == null:
		selected_enemy = enemies.pick_random()
	return true

func _ready() -> void:
	turn_ended.connect(_on_turn_start)
	
