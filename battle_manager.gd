class_name BattleManager extends Node

signal turn_ended
signal battle_ended(has_won: bool)
signal attack_described(text)

static var player: playerStats = load("res://Characters/player.tres")
@export var enemies: Array[EnemyStats]
var deck: Array[Card]
var max_deck_size = 4

var selected_card: Card
var selected_skills: Array[Skill]
var selected_enemy : EnemyStats

var queue: Array[TrinitySet]
var clean_up: Array[TrinitySet]

func _on_turn_start():
	clear_selection()
	_pick_deck()

static func get_player():
	assert(player, "Player does not exist")
	return player

func process_turn():
	for e in enemies:
		_use_card(e.pick_card(), e)
	_use_card(selected_card, player)
	_apply_queued_cards()
	if enemies.filter(func(enemy: EnemyStats): return enemy.hp > 0).size() == 0:
		battle_ended.emit(true)
		return
	if player.hp <= .0:
		battle_ended.emit(false)
		return
	turn_ended.emit()

func clear_selection():
	selected_card = null
	selected_enemy = null

func select_card(card):
	selected_card = card

func select_enemy(enemy):
	selected_enemy = enemy

func _evoke_emotion(c : Card):
	player.current_emotion = c.evoke_emotion()

func _pick_deck():
	deck = []
	var picked_cards = player.move_set.filter(
		func(card: Card): return card.is_enabled_only(player.current_emotion)
	)
	picked_cards.shuffle()
	var picked_cards_size = picked_cards.size()
	for i in range(0, min(picked_cards_size, max_deck_size)):
		deck.append(picked_cards[i])

func _use_card(c: Card, dealer: Character):
	if dealer.is_stunned:
			return
	if dealer is playerStats:
		if not _check_player_choices():
			return
	if dealer is playerStats:
		_queue_player_card(c, selected_enemy)
		_evoke_emotion(c)
		return
	_queue_enemy_card(c, dealer)

func _apply_queued_cards():
	var remaining_cards: Array[TrinitySet]
	for trinity in queue:
		if trinity.apply_effect():
			attack_described.emit(trinity.get_attack_description())
		if trinity.is_done_for():
			clean_up.append(trinity)
			continue
		remaining_cards.append(trinity)
	queue = remaining_cards

func _clean_up_effects():
	for trinity in clean_up:
		trinity.clear_effect()
	clean_up = []

func _queue_player_card(c: Card, enemy: Character):
	for eff in c.effects:
		var skill = selected_skills.filter(eff.filter_skill)
		var target =  eff.who_to_apply(player, enemy)
		if eff is Ricochet and target == player:
			player.current_emotion = Character.EMOTIONS.HEARTSTRIKEN
		queue.append(TrinitySet.new(target, skill, eff.duplicate()))

func _queue_enemy_card(c: Card, dealer: EnemyStats):
	for eff in c.effects:
		var skill = dealer.skills.filter(eff.filter_skill)
		var target =  eff.who_to_apply(dealer, player)
		queue.append(TrinitySet.new(target, skill, eff.duplicate()))

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
	player = load("res://Characters/player.tres")
	turn_ended.connect(_on_turn_start)
	_pick_deck()
	
