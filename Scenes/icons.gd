class_name IconContainer
extends VBoxContainer

func add_to_container(tooltip: String, tex: CompressedTexture2D):
	var child = TextureRect.new()
	child.texture = tex
	child.tooltip_text = tooltip
	add_child(child)

func remove_from_container(something):
	return

func update_tooltip(t: String, idx = 0):
	get_child(idx).tooltip_text = t
