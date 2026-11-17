class_name BattleControl
extends Control

signal card_selected(card)
signal skill_toggled(skill_idx)

@onready var battle_manager : BattleManager = $"Battle Manager"
const ENEMY_CONTROL = preload("uid://bjxbch0ugch8a")

var selected_card: TextureCard
var skills: Array[TextureSkill]

func _spawn_cards():
	var deck : Array[Card] = battle_manager.player.move_set
	var length = min(deck.size(), 4)
	for i in range(0, length):
		var texture_card = TextureCard.new()
		texture_card.card_stats = deck[i]
		texture_card.texture_normal = deck[i].texture
		texture_card.tooltip_text = deck[i].descrpition
		texture_card.pressed.connect(
			func():
				battle_manager.select_card(texture_card.card_stats)
				card_selected.emit(texture_card)
				)
		%CardContainer.add_child(texture_card)
func _spawn_enemies():
	for e in battle_manager.enemies:
		var e_texture : EnemyControl = ENEMY_CONTROL.instantiate()
		%EnemyContainer.add_child(e_texture)
		e_texture.set_up(e, battle_manager.select_enemy, battle_manager.turn_ended)
func _spawn_skills():
	for s in battle_manager.player.skills:
		var s_texture := TextureSkill.new()
		s_texture.texture_normal = load("res://icon.svg") #TODO
		s_texture.skill_stats = s
		skills.append(s_texture)
		s_texture.pressed.connect(
			func():
				battle_manager.toggle_skill_to_list(s, skill_toggled)
		)
		%Skills.add_child(s_texture)
func _remove_cards():
	for c in %CardContainer.get_children():
		c.queue_free()
func _hook_gui_signals():
	card_selected.connect(
		func(card: TextureCard):
			if selected_card:
				selected_card.modulate = Color.WHITE
			selected_card = card
			selected_card.modulate = Color.DARK_BLUE
	)
	skill_toggled.connect(
		func(skill):
			var s_texture = skills.filter(
				func(s: TextureSkill): return s.skill_stats == skill
			)[0]
			s_texture.modulate = Color.WHITE if s_texture.modulate == Color.NAVY_BLUE else Color.NAVY_BLUE
	)

func start_battle(enemies: Array[EnemyStats]):
	battle_manager.enemies = enemies
	_spawn_cards()
	_spawn_enemies()
	_spawn_skills()

func _ready() -> void:
	battle_manager.turn_ended.connect(
		func():
			_remove_cards()
			_spawn_cards())
	_hook_gui_signals()
	$EndTurn.pressed.connect(battle_manager.process_turn)
	%PlayerControl.set_up(battle_manager.turn_ended, battle_manager.player)
