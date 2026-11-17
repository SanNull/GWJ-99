extends Control

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var emotion: TextureRect = $Emotion
var player_stats: playerStats

func set_up(on_turn_start: Signal, player_stats: playerStats):
	on_turn_start.connect(func(): progress_bar.value = player_stats.hp)
	progress_bar.value = player_stats.hp
