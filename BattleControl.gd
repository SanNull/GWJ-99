extends Control

@onready var battle_manager : BattleManager = $BattleManager
const ENEMY_CONTROL = preload("uid://bjxbch0ugch8a")
const a  = preload("res://baseEnemy.tres")

var set_card := func(selected_card): 
	battle_manager.selected_card = selected_card
	print(battle_manager.selected_card)
var set_enemy := func(selected_enemy): 
	battle_manager.selected_enemy = selected_enemy
	print(battle_manager.selected_enemy)

func set_enemies(enemy_group: Array[Character]):
	battle_manager.enemies = enemy_group

func _spawn_cards():
	battle_manager.player.move_set.shuffle()
	var deck : Array[Card] = battle_manager.player.move_set
	var length = min(deck.size(), 4)
	for i in range(0, length):
		var texture_card = TextureCard.new()
		texture_card.card_stats = deck[i]
		texture_card.texture_normal = deck[i].texture
		texture_card.tooltip_text = deck[i].descrpition
		texture_card.pressed.connect(
			set_card.bind(texture_card.card_stats)
			)
		%CardContainer.add_child(texture_card)
func _spawn_enemies():
	for e in battle_manager.enemies:
		var e_texture : EnemyControl = ENEMY_CONTROL.instantiate()
		%EnemyContainer.add_child(e_texture)
		e_texture.set_up(e, set_enemy, battle_manager.turn_started)
func _spawn_skills():
	for s in battle_manager.player.skills:
		var s_texture := TextureButton.new()
		s_texture.texture_normal = load("res://icon.svg") #TODO
		s_texture.pressed.connect(battle_manager._add_skill_to_list.bind(s))
		%Skills.add_child(s_texture)

func _remove_cards():
	for c in %CardContainer.get_children():
		c.queue_free()

func _ready() -> void:
	set_enemies([a])
	_spawn_cards()
	_spawn_enemies()
	_spawn_skills()
	
	battle_manager.turn_started.connect(
		func():
			_remove_cards()
			_spawn_cards()
	)
	$EndTurn.pressed.connect(battle_manager.on_turn_end)
	%PlayerControl.set_up(battle_manager.turn_started, battle_manager.player)
