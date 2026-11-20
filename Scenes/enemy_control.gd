class_name EnemyControl
extends VBoxContainer
@onready var texture_button: TextureButton = $TextureButton
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var defense: TextureRect = $Icons/Defense

var enemy_stats: Character

func set_up(enemy: Character, pressed : Callable, on_turn_start: Signal):
	texture_button.pressed.connect(pressed.bind(enemy))
	enemy_stats = enemy
	progress_bar.value = enemy_stats.hp
	defense.tooltip_text = "Defense: %s" % [enemy_stats.defense]
	on_turn_start.connect(func(): 
		progress_bar.value = enemy_stats.hp
		defense.tooltip_text = "Defense: %s" % [enemy_stats.defense]
		)
	
