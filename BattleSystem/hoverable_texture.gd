class_name HoverableTexture
extends Control

@export var description: String = ""

func set_description(title: String,d: String, formatters: Array[Variant] = []):
	description += title + "\n"
	if not formatters:
		description += d
		return
	description += d % formatters
	$RichTextLabel.text = description


func _on_texture_button_mouse_entered() -> void:
	if not description:
		return
	$RichTextLabel.show()


func _on_texture_button_mouse_exited() -> void:
	$RichTextLabel.hide()
