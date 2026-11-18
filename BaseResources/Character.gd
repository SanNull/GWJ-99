class_name Character
extends Resource

enum EMOTIONS {
	#PLAYER
	ABNORMAL = 0,
	HEARTSTRIKEN,
	YEARNING,
	ROBOTIC,
	FEAR,
	NONE
}

@export var move_set: Array[Card]
@export var hp := 100.0
var max_hp: float
@export var defense := 5.0
@export var current_emotion: EMOTIONS  = EMOTIONS.ABNORMAL
@export var is_stunned :bool = false
@export var skills : Array[Skill]

func _init() -> void:
	max_hp = hp

func debug_print(name: String = "player"):
	print(name + " Hp: " + str(hp) + "\nDefense " + str(defense))
