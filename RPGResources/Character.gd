class_name Character
extends Resource

enum EMOTIONS {
	EXCITED = 0,
	HEARTSTRIKEN,
	YEARNING,
	QUEER
}

@export var move_set: Array[Card]
@export var hp := 100.0
@export var defense := 5.0
@export var current_emotion: EMOTIONS  = EMOTIONS.EXCITED


func debug_print(name: String = "player"):
	print(name + " Hp: " + str(hp) + "\nDefense " + str(defense))
