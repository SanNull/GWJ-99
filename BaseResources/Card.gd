class_name Card extends Resource

@export var title: String
@export var descrpition: String

@export var effects: Array[Effect]

@export var enabled_emotions: Array[Character.EMOTIONS]
@export var evoked_emotion: Character.EMOTIONS = Character.EMOTIONS.NONE
@export var chance: float

@export var texture: CompressedTexture2D= load("res://icon.svg")

func is_enabled_only(emotion: Character.EMOTIONS):
	return emotion in enabled_emotions or len(enabled_emotions) == 0

func evoke_emotion():
	if evoked_emotion == Character.EMOTIONS.NONE:
		return BattleManager.get_player().current_emotion
	var r := randf_range(.0, 1.0)
	if r <= chance:
		return evoked_emotion
	return BattleManager.get_player().current_emotion
