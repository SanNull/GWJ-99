@tool
class_name Card extends Resource

@export var descrpition: String
@export var duration := 1
@export var start_on_next_turn := false
@export var effects: Array[Effect]
@export var texture: CompressedTexture2D= load("res://icon.svg")
