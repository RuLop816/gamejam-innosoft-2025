extends TextEdit

var text_frame = self

func _on_dice_pressed() -> void:
	text_frame.text = str(randi_range(1,6))
